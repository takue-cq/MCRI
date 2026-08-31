import SwiftUI

struct CohortDetailView: View {
    let cohortNumber: Int
    @State private var students: [Student] = []
    @State private var showingAddStudentSheet = false
    @State private var studentToDelete: Student?

    private var filteredStudents: [Student] {
        students.filter { $0.cohort == cohortNumber }
    }

    var body: some View {
        ZStack {
            IconGridBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    MatterHeader(title: "Cohort \(cohortNumber)", subtitle: "\(filteredStudents.count) students")
                        .overlay(alignment: .topTrailing) {
                            Button {
                                showingAddStudentSheet = true
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(Theme.textWhite)
                            }
                        }

                    ForEach(filteredStudents) { student in
                        HStack(spacing: 14) {
                            NavigationLink {
                                StudentDetailView(student: student)
                            } label: {
                                HStack(spacing: 14) {
                                    Image(systemName: student.imageName)
                                        .font(.system(size: 30))
                                        .foregroundColor(Theme.textWhite.opacity(0.85))

                                    Text(student.name)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(Theme.textWhite)

                                    Spacer()

                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 14, weight: .semibold))
                                        .foregroundColor(Theme.textWhite.opacity(0.6))
                                }
                            }
                            .buttonStyle(PlainButtonStyle())

                            Button {
                                studentToDelete = student
                            } label: {
                                Image(systemName: "trash.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(Theme.textWhite.opacity(0.6))
                            }
                        }
                        .padding(14)
                        .background(Theme.textWhite.opacity(0.12))
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                }
                .padding(24)
            }
        }
        .navigationTitle("Cohort \(cohortNumber)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .sheet(isPresented: $showingAddStudentSheet) {
            AddStudentView(cohortNumber: cohortNumber)
        }
        .alert("Delete Student", isPresented: .constant(studentToDelete != nil)) {
            Button("Cancel", role: .cancel) {
                studentToDelete = nil
            }
            Button("Delete", role: .destructive) {
                if let studentToDelete = studentToDelete {
                    StudentRepository.shared.deleteStudent(byId: studentToDelete.id)
                    loadStudents()
                }
                studentToDelete = nil
            }
        } message: {
            if let studentToDelete = studentToDelete {
                Text("Are you sure you want to delete \(studentToDelete.name)?")
            }
        }
        .onAppear {
            loadStudents()
        }
    }

    private func loadStudents() {
        students = StudentRepository.shared.getAllStudents()
    }
}

#Preview {
    NavigationStack { CohortDetailView(cohortNumber: 1) }
}
