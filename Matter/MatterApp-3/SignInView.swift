import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showNotConnectedAlert = false

    var body: some View {
        ZStack {
            IconGridBackground()

            VStack(spacing: 20) {
                Spacer().frame(height: 20)

                MatterHeader(title: "Sign In", subtitle: "Welcome back")
                    .padding(.horizontal, 24)

                VStack(spacing: 14) {
                    TextField("Email", text: $email)
                        .textFieldStyle(.plain)
                        .padding(15)
                        .background(Theme.textWhite.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)

                    SecureField("Password", text: $password)
                        .textFieldStyle(.plain)
                        .padding(14)
                        .background(Theme.textWhite.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                }
                .padding(.horizontal, 24)

                Button {
                    // TODO: hook up real authentication
                    showNotConnectedAlert = true
                } label: {
                    Text("Sign In")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(Theme.matterOrangeDark)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Theme.textWhite)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
                .padding(.horizontal, 24)

                Spacer()
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .alert("Sign-in coming soon", isPresented: $showNotConnectedAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("This app isn't connected to an authentication backend yet.")
        }
    }
}

#Preview {
    NavigationStack { SignInView() }
}
