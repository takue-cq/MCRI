import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Image("HomeBackground")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                // Space reserved for the logo already baked into HomeBackground
                Spacer()
                    .frame(height: 90)
                
                Spacer()
                
                VStack(spacing: 16) {
                    NavigationLink {
                        StudentsView()
                    } label: {
                        HomeActionRow(
                            icon: "graduationcap.fill",
                            title: "Explore Students",
                            subtitle: "Browse cohorts"
                        )
                    }
                    
                    NavigationLink {
                        StaffView()
                    } label: {
                        HomeActionRow(
                            icon: "person.2.fill",
                            title: "Explore Staff",
                            subtitle: "Meet the Matter team"
                        )
                    }
                    
                    NavigationLink {
                        SignInView()
                    } label: {
                        HomeActionRow(
                            icon: "person.crop.circle.badge.checkmark",
                            title: "Sign In",
                            subtitle: "Already a member? Sign in here"
                        )
                    }
                }
                .padding(.horizontal, 50)
                .padding(.bottom, 60)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

private struct HomeActionRow: View {
    let icon: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(Theme.matterOrangeDark)
                .frame(width: 46, height: 46)
                .background(Theme.textWhite)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(Theme.textWhite)
                Text(subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(Theme.textWhite.opacity(0.8))
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(Theme.textWhite.opacity(0.8))
        }
        .padding(16)
        .background(Theme.textWhite.opacity(0.12))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    NavigationStack { HomeView() }
}
