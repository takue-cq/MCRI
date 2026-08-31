import SwiftUI

struct CohortDetailView: View {
    let cohortNumber: Int

    // Placeholder roster — replace with real data source (API, JSON, etc.)
    private var students: [String] {
        (1...8).map { "Student \($0) — Cohort \(cohortNumber)" }
    }

    var body: some View {
        ZStack {
            IconGridBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    MatterHeader(title: "Cohort \(cohortNumber)", subtitle: "\(students.count) students")

                    ForEach(students, id: \.self) { name in
                        HStack(spacing: 14) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Theme.textWhite.opacity(0.85))

                            Text(name)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Theme.textWhite)

                            Spacer()
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
    }
}

#Preview {
    NavigationStack { CohortDetailView(cohortNumber: 1) }
}
