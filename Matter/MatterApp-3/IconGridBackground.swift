import SwiftUI

/// Faint repeating grid of tech/education icons, echoing the watermark pattern
/// behind the Matter logo on the splash and header screens.
struct IconGridBackground: View {
    private let icons = [
        "desktopcomputer", "lightbulb", "airplane", "person.2.fill",
        "ipad", "graduationcap.fill", "person.3.fill", "iphone"
    ]

    var body: some View {
        GeometryReader { geo in
            let columns = 7
            let rows = 14
            let spacing = geo.size.width / CGFloat(columns)

            ZStack {
                Theme.matterOrange.ignoresSafeArea()

                VStack(spacing: spacing * 0.55) {
                    ForEach(0..<rows, id: \.self) { row in
                        HStack(spacing: spacing * 0.55) {
                            ForEach(0..<columns, id: \.self) { col in
                                Image(systemName: icons[(row + col) % icons.count])
                                    .font(.system(size: spacing * 0.35))
                                    .foregroundColor(Theme.textWhite.opacity(0.06))
                            }
                        }
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
}
