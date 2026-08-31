import SwiftUI

struct StudentsView: View {
    private let cohorts = Array(1...7)
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var showingAddCohortAlert = false
    @State private var newCohortNumber = ""

    private var availableCohorts: [Int] {
        let allStudents = StudentRepository.shared.getAllStudents()
        let uniqueCohorts = Set(allStudents.map { $0.cohort })
        return uniqueCohorts.sorted()
    }

    var body: some View {
        ZStack {
            IconGridBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    MatterHeader(title: "Students", subtitle: "Select a cohort to explore")
                        .overlay(alignment: .topTrailing) {
                            Button {
                                showingAddCohortAlert = true
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(Theme.textWhite)
                            }
                        }

                    if availableCohorts.isEmpty {
                        VStack(spacing: 16) {
                            Image(systemName: "person.3")
                                .font(.system(size: 48))
                                .foregroundColor(Theme.textWhite.opacity(0.4))

                            Text("No cohorts yet")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(Theme.textWhite.opacity(0.6))

                            Text("Tap the + button to create your first cohort")
                                .font(.system(size: 14))
                                .foregroundColor(Theme.textWhite.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 60)
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(availableCohorts, id: \.self) { number in
                                NavigationLink {
                                    CohortDetailView(cohortNumber: number)
                                } label: {
                                    CohortTile(number: number)
                                }
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
        .alert("Add New Cohort", isPresented: $showingAddCohortAlert) {
            TextField("Cohort Number", text: $newCohortNumber)
                .keyboardType(.numberPad)
            Button("Cancel", role: .cancel) {
                newCohortNumber = ""
            }
            Button("Add") {
                if let cohortNumber = Int(newCohortNumber), cohortNumber > 0 {
                    StudentRepository.shared.createCohort(cohortNumber: cohortNumber)
                    newCohortNumber = ""
                }
            }
        } message: {
            Text("Enter the cohort number to create a new cohort with sample students.")
        }
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
