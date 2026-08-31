import SwiftUI

struct StaffView: View {
    private let staff = [
        "Program Director", "Career Coach", "Curriculum Lead",
        "Industry Partnerships", "Student Success Advisor"
    ]

    var body: some View {
        ZStack {
            IconGridBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    MatterHeader(title: "Staff", subtitle: "Meet the Matter team")

                    ForEach(staff, id: \.self) { role in
                        HStack(spacing: 14) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 30))
                                .foregroundColor(Theme.textWhite.opacity(0.85))

                            Text(role)
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
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
}

#Preview {
    NavigationStack { StaffView() }
}
