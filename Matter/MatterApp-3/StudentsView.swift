import SwiftUI

struct StudentsView: View {
    private let cohorts = Array(1...7)
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack {
            IconGridBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    MatterHeader(title: "Students", subtitle: "Select a cohort to explore")

                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(cohorts, id: \.self) { number in
                            NavigationLink {
                                CohortDetailView(cohortNumber: number)
                            } label: {
                                CohortTile(number: number)
                            }
                        }
                    }
                }
                .padding(24)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

private struct CohortTile: View {
    let number: Int

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "person.3.fill")
                .font(.system(size: 26, weight: .semibold))
                .foregroundColor(Theme.matterOrangeDark)
                .frame(width: 56, height: 56)
                .background(Theme.textWhite)
                .clipShape(Circle())

            Text("Cohort \(number)")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Theme.textWhite)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(Theme.textWhite.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    NavigationStack { StudentsView() }
}
