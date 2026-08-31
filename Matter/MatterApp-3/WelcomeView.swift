import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack {
            Image("WelcomeBackground")
                .resizable()
                .ignoresSafeArea()

            VStack(spacing: 18) {
                Spacer()
                Spacer()

                NavigationLink {
                    HomeView()
                } label: {
                    Text("Get Started")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Theme.matterOrangeDark)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Theme.textWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack { WelcomeView() }
}
