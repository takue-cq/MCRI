import SwiftUI

struct AddStaffView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var role = ""
    @State private var email = ""
    @State private var bio = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            ZStack {
                IconGridBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        MatterHeader(title: "Add Staff", subtitle: "Enter staff details")

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Name")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Theme.textWhite.opacity(0.7))
                                .textCase(.uppercase)

                            TextField("Full name", text: $name)
                                .font(.system(size: 16))
                                .foregroundColor(Color.black)
                                .textFieldStyle(.plain)
                                .padding(15)
                                .background(Theme.inputBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Role")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Theme.textWhite.opacity(0.7))
                                .textCase(.uppercase)

                            TextField("Job title", text: $role)
                                .font(.system(size: 16))
                                .foregroundColor(Color.black)
                                .textFieldStyle(.plain)
                                .padding(15)
                                .background(Theme.inputBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Theme.textWhite.opacity(0.7))
                                .textCase(.uppercase)

                            TextField("Email address", text: $email)
                                .font(.system(size: 16))
                                .foregroundColor(Color.black)
                                .textFieldStyle(.plain)
                                .padding(15)
                                .background(Theme.inputBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Bio")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Theme.textWhite.opacity(0.7))
                                .textCase(.uppercase)

                            TextEditor(text: $bio)
                                .font(.system(size: 16))
                                .foregroundColor(Color.black)
                                .frame(minHeight: 100)
                                .padding(15)
                                .background(Theme.inputBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .scrollContentBackground(.hidden)
                        }

                        Button {
                            addStaff()
                        } label: {
                            Text("Add Staff")
                                .font(.system(size: 17, weight: .semibold))
                                .foregroundColor(Theme.matterOrangeDark)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 16)
                                .background(Theme.textWhite)
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(Theme.textWhite.opacity(0.8))
                }
            }
            .alert("Error", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    private func addStaff() {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter a name"
            showingAlert = true
            return
        }

        guard !role.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter a role"
            showingAlert = true
            return
        }

        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter an email"
            showingAlert = true
            return
        }

        let newStaff = Staff(
            name: name.trimmingCharacters(in: .whitespaces),
            role: role.trimmingCharacters(in: .whitespaces),
            email: email.trimmingCharacters(in: .whitespaces),
            bio: bio.trimmingCharacters(in: .whitespaces)
        )

        StaffRepository.shared.addStaff(newStaff)
        dismiss()
    }
}

#Preview {
    AddStaffView()
}
