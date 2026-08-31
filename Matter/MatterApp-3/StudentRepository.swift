import Foundation

class StudentRepository {
    static let shared = StudentRepository()
    
    private let fileName = "students.json"
    private var students: [Student] = []
    private let useAPI = false // Set to true to use API, false for local-only mode
    
    private init() {
        loadStudents()
        // Initialize with sample data if empty
        if students.isEmpty {
            createSampleData()
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func getFileURL() -> URL {
        getDocumentsDirectory().appendingPathComponent(fileName)
    }
    
    // MARK: - Persistence
    
    func loadStudents() {
        if useAPI {
            loadFromAPI()
        } else {
            loadFromLocal()
        }
    }
    
    private func loadFromLocal() {
        let fileURL = getFileURL()
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            students = try decoder.decode([Student].self, from: data)
        } catch {
            print("Error loading students: \(error)")
        }
    }
    
    private func loadFromAPI() {
        guard let url = URL(string: APIConfig.studentsEndpoint) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("API Error: \(error)")
                // Fallback to local if API fails
                DispatchQueue.main.async {
                    self.loadFromLocal()
                }
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let loadedStudents = try decoder.decode([Student].self, from: data)
                DispatchQueue.main.async {
                    self.students = loadedStudents
                    self.saveToLocal() // Cache locally
                }
            } catch {
                print("Error decoding API response: \(error)")
                DispatchQueue.main.async {
                    self.loadFromLocal()
                }
            }
        }.resume()
    }
    
    func saveStudents() {
        saveToLocal()
        if useAPI {
            syncToAPI()
        }
    }
    
    private func saveToLocal() {
        let fileURL = getFileURL()
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(students)
            try data.write(to: fileURL)
        } catch {
            print("Error saving students: \(error)")
        }
    }
    
    private func syncToAPI() {
        // Sync all students to API
        guard let url = URL(string: APIConfig.studentsEndpoint) else { return }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(students)
            
            URLSession.shared.dataTask(with: request) { _, response, error in
                if let error = error {
                    print("API Sync Error: \(error)")
                }
            }.resume()
        } catch {
            print("Error encoding for API: \(error)")
        }
    }
    
    // MARK: - CRUD Operations
    
    func getAllStudents() -> [Student] {
        return students
    }
    
    func getStudents(byCohort cohort: Int) -> [Student] {
        return students.filter { $0.cohort == cohort }
    }
    
    func getStudent(byId id: UUID) -> Student? {
        return students.first { $0.id == id }
    }
    
    func updateStudent(_ student: Student) {
        if let index = students.firstIndex(where: { $0.id == student.id }) {
            students[index] = student
            saveStudents()
            
            if useAPI {
                updateStudentOnAPI(student)
            }
        }
    }
    
    private func updateStudentOnAPI(_ student: Student) {
        guard let url = URL(string: APIConfig.studentEndpoint(id: student.id.uuidString)) else { return }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(student)
            
            URLSession.shared.dataTask(with: request) { _, response, error in
                if let error = error {
                    print("API Update Error: \(error)")
                }
            }.resume()
        } catch {
            print("Error encoding student for API: \(error)")
        }
    }
    
    func addStudent(_ student: Student) {
        students.append(student)
        saveStudents()
        
        if useAPI {
            addStudentToAPI(student)
        }
    }
    
    private func addStudentToAPI(_ student: Student) {
        guard let url = URL(string: APIConfig.studentsEndpoint) else { return }
        
        do {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(student)
            
            URLSession.shared.dataTask(with: request) { _, response, error in
                if let error = error {
                    print("API Add Error: \(error)")
                }
            }.resume()
        } catch {
            print("Error encoding student for API: \(error)")
        }
    }
    
    func deleteStudent(byId id: UUID) {
        students.removeAll { $0.id == id }
        saveStudents()

        if useAPI {
            deleteStudentFromAPI(id: id)
        }
    }

    func createCohort(cohortNumber: Int) {
        // Check if cohort already exists
        let existingStudents = students.filter { $0.cohort == cohortNumber }
        if !existingStudents.isEmpty {
            return // Cohort already has students
        }

        // Create sample students for the new cohort
        let sampleStudents = (1...8).map { index in
            Student(
                name: "Student \(cohortNumber)-\(index)",
                imageName: "person.crop.circle.fill",
                email: "student\(cohortNumber)-\(index)@example.com",
                bio: "Passionate learner in Cohort \(cohortNumber). Currently developing skills in mobile development and design.",
                skills: ["Swift", "SwiftUI", "Design"],
                cohort: cohortNumber,
                phase: Int.random(in: 1...6),
                gender: index % 2 == 0 ? "Female" : "Male",
                funFact: "I love coding and coffee!"
            )
        }

        students.append(contentsOf: sampleStudents)
        saveStudents()
    }
    
    private func deleteStudentFromAPI(id: UUID) {
        guard let url = URL(string: APIConfig.studentEndpoint(id: id.uuidString)) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("API Delete Error: \(error)")
            }
        }.resume()
    }
    
    // MARK: - Sample Data
    
    private func createSampleData() {
        let sampleStudents = (1...8).map { index in
            Student(
                name: "Student \(index)",
                imageName: "person.crop.circle.fill",
                email: "student\(index)@example.com",
                bio: "Passionate learner in Cohort 1. Currently developing skills in mobile development and design.",
                skills: ["Swift", "SwiftUI", "Design"],
                cohort: 1,
                phase: Int.random(in: 1...6),
                gender: index % 2 == 0 ? "Female" : "Male",
                funFact: "I love coding and coffee!"
            )
        }
        
        students = sampleStudents
        saveStudents()
    }
}
