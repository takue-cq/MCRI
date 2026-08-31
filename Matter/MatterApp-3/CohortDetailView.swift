import SwiftUI

struct CohortDetailView: View {
    let cohortNumber: Int

    // Placeholder roster — replace with real data source (API, JSON, etc.)
    private var students: [Student] {
        (1...8).map { index in
            Student(
                name: "Student \(index)",
                imageName: "person.crop.circle.fill",
                email: "student\(index)@example.com",
                bio: "Passionate learner in Cohort \(cohortNumber). Currently developing skills in mobile development and design.",
                skills: ["Swift", "SwiftUI", "Design"],
                cohort: cohortNumber,
                phase: Int.random(in: 1...6),
                gender: index % 2 == 0 ? "Female" : "Male",
                funFact: "I love coding and coffee!"
            )
        }
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
