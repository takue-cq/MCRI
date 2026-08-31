import Foundation

class StaffRepository {
    static let shared = StaffRepository()
    
    private let fileName = "staff.json"
    private var staff: [Staff] = []
    
    private init() {
        loadStaff()
        // Initialize with sample data if empty
        if staff.isEmpty {
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
    
    func loadStaff() {
        let fileURL = getFileURL()
        
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            staff = try decoder.decode([Staff].self, from: data)
        } catch {
            print("Error loading staff: \(error)")
        }
    }
    
    func saveStaff() {
        let fileURL = getFileURL()
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(staff)
            try data.write(to: fileURL)
        } catch {
            print("Error saving staff: \(error)")
        }
    }
    
    // MARK: - CRUD Operations
    
    func getAllStaff() -> [Staff] {
        return staff
    }
    
    func getStaff(byId id: UUID) -> Staff? {
        return staff.first { $0.id == id }
    }
    
    func addStaff(_ staffMember: Staff) {
        staff.append(staffMember)
        saveStaff()
    }
    
    func updateStaff(_ staffMember: Staff) {
        if let index = staff.firstIndex(where: { $0.id == staffMember.id }) {
            staff[index] = staffMember
            saveStaff()
        }
    }
    
    func deleteStaff(byId id: UUID) {
        staff.removeAll { $0.id == id }
        saveStaff()
    }
    
    // MARK: - Sample Data
    
    private func createSampleData() {
        let sampleStaff = [
            Staff(
                name: "Sarah Johnson",
                role: "Program Director",
                email: "sarah.johnson@matter.com",
                bio: "Leading the program with 10+ years of experience in education and technology."
            ),
            Staff(
                name: "Michael Chen",
                role: "Career Coach",
                email: "michael.chen@matter.com",
                bio: "Helping students navigate their career paths and achieve their professional goals."
            ),
            Staff(
                name: "Emily Rodriguez",
                role: "Curriculum Lead",
                email: "emily.rodriguez@matter.com",
                bio: "Designing and implementing cutting-edge curriculum for modern tech education."
            ),
            Staff(
                name: "David Kim",
                role: "Industry Partnerships",
                email: "david.kim@matter.com",
                bio: "Building relationships with industry leaders to create opportunities for students."
            ),
            Staff(
                name: "Lisa Thompson",
                role: "Student Success Advisor",
                email: "lisa.thompson@matter.com",
                bio: "Supporting students throughout their journey and ensuring their success."
            )
        ]
        
        staff = sampleStaff
        saveStaff()
    }
}
