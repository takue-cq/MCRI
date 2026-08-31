import SwiftUI

struct CohortDetailView: View {
    let cohortNumber: Int

    private var students: [Student] {
        StudentRepository.shared.getStudents(byCohort: cohortNumber)
    }

    var body: some View {
        ZStack {
            IconGridBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    MatterHeader(title: "Cohort \(cohortNumber)", subtitle: "\(students.count) students")

                    ForEach(students) { student in
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
                            .padding(14)
                            .background(Theme.textWhite.opacity(0.12))
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(24)
            }
        }
        .navigationTitle("Cohort \(cohortNumber)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

#Preview {
    NavigationStack { CohortDetailView(cohortNumber: 1) }
}
