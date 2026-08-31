import SwiftUI

struct ProgressGraphView: View {
    let student: Student

    // Different colors for each phase
    private let phaseColors: [Color] = [
        Color(red: 0.2, green: 0.6, blue: 0.8),   // Phase 1 - Blue
        Color(red: 0.3, green: 0.7, blue: 0.5),   // Phase 2 - Teal
        Color(red: 0.5, green: 0.7, blue: 0.3),   // Phase 3 - Green
        Color(red: 0.8, green: 0.7, blue: 0.2),   // Phase 4 - Yellow
        Color(red: 0.9, green: 0.5, blue: 0.2),   // Phase 5 - Orange
        Color(red: 0.82, green: 0.38, blue: 0.18) // Phase 6 - Matter Orange
    ]

    private let phaseNames = [
        "Foundation",
        "Exploration",
        "Development",
        "Refinement",
        "Integration",
        "Mastery"
    ]

    var body: some View {
        ZStack {
            IconGridBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    MatterHeader(
                        title: "Progress",
                        subtitle: "\(student.name)'s journey through the program"
                    )

                    // Progress Overview
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Current Progress")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Theme.textWhite.opacity(0.7))
                            .textCase(.uppercase)

                        HStack(spacing: 16) {
                            Text("Phase \(student.phase) of 6")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Theme.textPrimary)

                            Spacer()

                            Text("\(Int(Double(student.phase) / 6.0 * 100))% Complete")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(phaseColors[student.phase - 1])
                        }
                    }
                    .padding(16)
                    .background(Theme.textWhite.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                    // Phase Progress Graph
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Phase Breakdown")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Theme.textWhite.opacity(0.7))
                            .textCase(.uppercase)

                        VStack(spacing: 12) {
                            ForEach(1...6, id: \.self) { phase in
                                PhaseRow(
                                    phaseNumber: phase,
                                    phaseName: phaseNames[phase - 1],
                                    color: phaseColors[phase - 1],
                                    isCompleted: phase <= student.phase,
                                    isCurrent: phase == student.phase
                                )
                            }
                        }
                    }
                    .padding(16)
                    .background(Theme.textWhite.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                    // Visual Bar Chart
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Visual Progress")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Theme.textWhite.opacity(0.7))
                            .textCase(.uppercase)

                        HStack(alignment: .bottom, spacing: 8) {
                            ForEach(1...6, id: \.self) { phase in
                                VStack(spacing: 6) {
                                    Spacer()
                                    
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(phase <= student.phase ? phaseColors[phase - 1] : Theme.textWhite.opacity(0.2))
                                        .frame(height: phase == student.phase ? 80 : (phase < student.phase ? 60 : 40))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 6)
                                                .stroke(phase == student.phase ? Theme.textWhite : Color.clear, lineWidth: 2)
                                        )
                                    
                                    Text("P\(phase)")
                                        .font(.system(size: 11, weight: .medium))
                                        .foregroundColor(Theme.textWhite.opacity(0.8))
                                }
                                .frame(maxWidth: .infinity)
                            }
                        }
                        .frame(height: 120)
                    }
                    .padding(16)
                    .background(Theme.textWhite.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                    // Phase Description
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Current Phase: \(phaseNames[student.phase - 1])")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Theme.textWhite.opacity(0.7))
                            .textCase(.uppercase)

                        Text(getPhaseDescription(for: student.phase))
                            .font(.system(size: 15))
                            .foregroundColor(Theme.textPrimary)
                            .lineSpacing(4)
                    }
                    .padding(16)
                    .background(phaseColors[student.phase - 1].opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
                .padding(24)
            }
        }
        .navigationTitle("Progress")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }

    private func getPhaseDescription(for phase: Int) -> String {
        switch phase {
        case 1:
            return "Building the foundation. Learning core concepts and establishing fundamental skills."
        case 2:
            return "Exploring possibilities. Diving deeper into topics and discovering areas of interest."
        case 3:
            return "Active development. Working on projects and applying knowledge in practical ways."
        case 4:
            return "Refining skills. Polishing work and improving based on feedback and experience."
        case 5:
            return "Integration phase. Combining learned skills and preparing for final challenges."
        case 6:
            return "Mastery achieved. Demonstrating comprehensive understanding and professional capability."
        default:
            return ""
        }
    }
}

struct PhaseRow: View {
    let phaseNumber: Int
    let phaseName: String
    let color: Color
    let isCompleted: Bool
    let isCurrent: Bool

    var body: some View {
        HStack(spacing: 12) {
            // Phase Number Circle
            ZStack {
                Circle()
                    .fill(isCompleted ? color : Theme.textWhite.opacity(0.2))
                    .frame(width: 36, height: 36)

                if isCompleted {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(Theme.textWhite)
                } else {
                    Text("\(phaseNumber)")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Theme.textTertiary)
                }
            }

            // Phase Name
            VStack(alignment: .leading, spacing: 2) {
                Text(phaseName)
                    .font(.system(size: 16, weight: isCurrent ? .semibold : .medium))
                    .foregroundColor(isCompleted ? Theme.textPrimary : Theme.textTertiary)

                if isCurrent {
                    Text("Current Phase")
                        .font(.system(size: 12))
                        .foregroundColor(color)
                }
            }

            Spacer()

            // Status Indicator
            if isCompleted {
                Image(systemName: "circle.fill")
                    .font(.system(size: 8))
                    .foregroundColor(color)
            } else if isCurrent {
                Image(systemName: "circle.fill")
                    .font(.system(size: 8))
                    .foregroundColor(color)
                    .symbolEffect(.pulse, options: .repeating)
            }
        }
        .padding(12)
        .background(isCurrent ? color.opacity(0.2) : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    NavigationStack {
        ProgressGraphView(
            student: Student(
                name: "Alex Johnson",
                imageName: "person.crop.circle.fill",
                email: "alex.johnson@example.com",
                bio: "Passionate about mobile development.",
                skills: ["Swift", "SwiftUI"],
                cohort: 1,
                phase: 3,
                gender: "Male",
                funFact: "I love hiking!"
            )
        )
    }
}
