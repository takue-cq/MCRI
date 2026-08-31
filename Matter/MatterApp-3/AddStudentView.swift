import SwiftUI

struct AddStudentView: View {
    @Environment(\.dismiss) private var dismiss
    let cohortNumber: Int
    
    @State private var name = ""
    @State private var email = ""
    @State private var bio = ""
    @State private var skills = ""
    @State private var phase = 1
    @State private var gender = ""
    @State private var funFact = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            ZStack {
                IconGridBackground()

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        MatterHeader(title: "Add Student", subtitle: "Enter student details")

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Name")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Theme.textWhite.opacity(0.7))
                                .textCase(.uppercase)

                            TextField("Full name", text: $name)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                                .textFieldStyle(.plain)
                                .padding(15)
                                .background(Theme.textWhite.opacity(0.9))
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Theme.textWhite.opacity(0.7))
                                .textCase(.uppercase)

                            TextField("Email address", text: $email)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                                .textFieldStyle(.plain)
                                .padding(15)
                                .background(Theme.textWhite.opacity(0.9))
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
                                .foregroundColor(Theme.textWhite)
                                .frame(minHeight: 80)
                                .padding(15)
                                .background(Theme.textWhite.opacity(0.9))
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .scrollContentBackground(.hidden)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Skills")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Theme.textWhite.opacity(0.7))
                                .textCase(.uppercase)

                            TextField("Skills (comma separated)", text: $skills)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                                .textFieldStyle(.plain)
                                .padding(15)
                                .background(Theme.textWhite.opacity(0.9))
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .autocapitalization(.none)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Phase")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Theme.textWhite.opacity(0.7))
                                .textCase(.uppercase)

                            Picker("Phase", selection: $phase) {
                                ForEach(1...6, id: \.self) { phase in
                                    Text("Phase \(phase)").tag(phase)
                                }
                            }
                            .pickerStyle(.segmented)
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Gender")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Theme.textWhite.opacity(0.7))
                                .textCase(.uppercase)

                            TextField("Gender", text: $gender)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                                .textFieldStyle(.plain)
                                .padding(15)
                                .background(Theme.textWhite.opacity(0.9))
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        }

                        VStack(alignment: .leading, spacing: 8) {
                            Text("Fun Fact")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Theme.textWhite.opacity(0.7))
                                .textCase(.uppercase)

                            TextEditor(text: $funFact)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                                .frame(minHeight: 60)
                                .padding(15)
                                .background(Theme.textWhite.opacity(0.9))
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .scrollContentBackground(.hidden)
                        }

                        Button {
                            addStudent()
                        } label: {
                            Text("Add Student")
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

    private func addStudent() {
        guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter a name"
            showingAlert = true
            return
        }

        guard !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            alertMessage = "Please enter an email"
            showingAlert = true
            return
        }

        let skillsArray = skills.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }

        let newStudent = Student(
            name: name.trimmingCharacters(in: .whitespaces),
            imageName: "person.crop.circle.fill",
            email: email.trimmingCharacters(in: .whitespaces),
            bio: bio.trimmingCharacters(in: .whitespaces),
            skills: skillsArray.isEmpty ? ["Swift", "SwiftUI"] : skillsArray,
            cohort: cohortNumber,
            phase: phase,
            gender: gender.trimmingCharacters(in: .whitespaces).isEmpty ? "Not specified" : gender.trimmingCharacters(in: .whitespaces),
            funFact: funFact.trimmingCharacters(in: .whitespaces).isEmpty ? "No fun fact yet" : funFact.trimmingCharacters(in: .whitespaces)
        )

        StudentRepository.shared.addStudent(newStudent)
        dismiss()
    }
}

#Preview {
    AddStudentView(cohortNumber: 1)
}
