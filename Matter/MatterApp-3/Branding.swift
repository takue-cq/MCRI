//
//  Branding.swift
//  Matter
//
//  Shared brand elements used across screens for a consistent look.
//

import SwiftUI

/// Simple stylized rendition of the diamond "M" mark from the Matter logo.
struct MatterMark: View {
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: 20, y: 18))
                path.addLine(to: CGPoint(x: 0, y: 36))
                path.addLine(to: CGPoint(x: 8, y: 36))
                path.addLine(to: CGPoint(x: 28, y: 18))
                path.addLine(to: CGPoint(x: 8, y: 0))
                path.closeSubpath()
            }
            .fill(Theme.textWhite)

            Path { path in
                path.move(to: CGPoint(x: 20, y: 0))
                path.addLine(to: CGPoint(x: 40, y: 18))
                path.addLine(to: CGPoint(x: 20, y: 36))
                path.addLine(to: CGPoint(x: 28, y: 18))
                path.closeSubpath()
            }
            .fill(Theme.textWhite.opacity(0.55))
        }
    }
}

/// Consistent screen header — logo mark, title, and optional subtitle —
/// used at the top of every secondary screen (Sign In, Students, Staff,
/// Cohort Detail) so the app reads as one cohesive product.
struct MatterHeader: View {
    let title: String
    var subtitle: String? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            MatterMark()
                .frame(width: 32, height: 29)
                .padding(.bottom, 4)

            Text(title)
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Theme.textWhite)

            if let subtitle {
                Text(subtitle)
                    .font(.system(size: 15))
                    .foregroundColor(Theme.textWhite.opacity(0.8))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 16)
    }
}

#Preview {
    ZStack {
        Theme.matterOrange.ignoresSafeArea()
        MatterHeader(title: "Students", subtitle: "Select a cohort to explore")
            .padding(24)
    }
}
