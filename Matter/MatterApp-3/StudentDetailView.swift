import SwiftUI
import PhotosUI

struct StudentDetailView: View {
    @State private var student: Student
    @State private var originalStudent: Student
    @State private var isEditing = false
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var profileImage: Image?

    init(student: Student) {
        _student = State(initialValue: student)
        _originalStudent = State(initialValue: student)
    }

    var body: some View {
        ZStack {
            IconGridBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Profile Image
                    ZStack {
                        Group {
                            if let profileImage = profileImage {
                                profileImage
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                Image(student.imageName)
                                    .resizable()
                                    .scaledToFill()
                            }
                        }
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Theme.textWhite, lineWidth: 3)
                        )
                        .shadow(radius: 10)
                        .frame(maxWidth: .infinity)

                        if isEditing {
                            PhotosPicker(
                                selection: $selectedPhoto,
                                matching: .images
                            ) {
                                Image(systemName: "camera.fill")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(Theme.matterOrangeDark)
                                    .frame(width: 36, height: 36)
                                    .background(Theme.textWhite)
                                    .clipShape(Circle())
                                    .shadow(radius: 4)
                            }
                            .offset(x: 40, y: 40)
                        }
                    }

                    // Name and Cohort
                    VStack(alignment: .leading, spacing: 8) {
                        if isEditing {
                            TextField("Name", text: $student.name)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Theme.textWhite)
                                .textFieldStyle(.plain)
                        } else {
                            Text(student.name)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(Theme.textWhite)
                        }

                        Text("Cohort \(student.cohort) • Phase \(student.phase)")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Theme.textWhite.opacity(0.8))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    // Email
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Theme.textWhite.opacity(0.7))
                            .textCase(.uppercase)

                        if isEditing {
                            TextField("Email", text: $student.email)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                                .textFieldStyle(.plain)
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                        } else {
                            Text(student.email)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                        }
                    }
                    .padding(16)
                    .background(Theme.textWhite.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                    // Bio
                    VStack(alignment: .leading, spacing: 8) {
                        Text("About")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Theme.textWhite.opacity(0.7))
                            .textCase(.uppercase)

                        if isEditing {
                            TextEditor(text: $student.bio)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                                .frame(minHeight: 80)
                                .scrollContentBackground(.hidden)
                        } else {
                            Text(student.bio)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                                .lineSpacing(4)
                        }
                    }
                    .padding(16)
                    .background(Theme.textWhite.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                    // Skills
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Skills")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Theme.textWhite.opacity(0.7))
                            .textCase(.uppercase)

                        if isEditing {
                            TextField("Skills (comma separated)", text: Binding(
                                get: { student.skills.joined(separator: ", ") },
                                set: { student.skills = $0.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) } }
                            ))
                            .font(.system(size: 16))
                            .foregroundColor(Theme.textWhite)
                            .textFieldStyle(.plain)
                            .autocapitalization(.none)
                        } else {
                            FlowLayout(spacing: 10) {
                                ForEach(student.skills, id: \.self) { skill in
                                    Text(skill)
                                        .font(.system(size: 14, weight: .medium))
                                        .foregroundColor(Theme.matterOrangeDark)
                                        .padding(.horizontal, 14)
                                        .padding(.vertical, 8)
                                        .background(Theme.textWhite)
                                        .clipShape(Capsule())
                                }
                            }
                        }
                    }
                    .padding(16)
                    .background(Theme.textWhite.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                    // Gender
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Gender")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Theme.textWhite.opacity(0.7))
                            .textCase(.uppercase)

                        if isEditing {
                            TextField("Gender", text: $student.gender)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                                .textFieldStyle(.plain)
                        } else {
                            Text(student.gender)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                        }
                    }
                    .padding(16)
                    .background(Theme.textWhite.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                    // Fun Fact
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Fun Fact")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Theme.textWhite.opacity(0.7))
                            .textCase(.uppercase)

                        if isEditing {
                            TextEditor(text: $student.funFact)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                                .frame(minHeight: 60)
                                .scrollContentBackground(.hidden)
                        } else {
                            Text(student.funFact)
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                                .lineSpacing(4)
                        }
                    }
                    .padding(16)
                    .background(Theme.textWhite.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                    // Phase
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Current Phase")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(Theme.textWhite.opacity(0.7))
                            .textCase(.uppercase)

                        if isEditing {
                            Picker("Phase", selection: $student.phase) {
                                ForEach(1...6, id: \.self) { phase in
                                    Text("Phase \(phase)").tag(phase)
                                }
                            }
                            .pickerStyle(.segmented)
                        } else {
                            Text("Phase \(student.phase) of 6")
                                .font(.system(size: 16))
                                .foregroundColor(Theme.textWhite)
                        }
                    }
                    .padding(16)
                    .background(Theme.textWhite.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

                    // Progress Button
                    NavigationLink {
                        ProgressGraphView(student: student)
                    } label: {
                        HStack(spacing: 12) {
                            Image(systemName: "chart.bar.fill")
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(Theme.matterOrangeDark)

                            Text("View Progress")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(Theme.textWhite)

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(Theme.textWhite.opacity(0.6))
                        }
                        .padding(16)
                        .background(Theme.matterOrange)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(24)
            }
        }
        .navigationTitle("Student Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isEditing {
                    HStack(spacing: 16) {
                        Button("Cancel") {
                            student = originalStudent
                            isEditing = false
                            profileImage = nil
                        }
                        .foregroundColor(Theme.textWhite.opacity(0.8))

                        Button("Save") {
                            StudentRepository.shared.updateStudent(student)
                            isEditing = false
                        }
                        .foregroundColor(Theme.matterOrange)
                        .fontWeight(.semibold)
                    }
                } else {
                    Button("Edit") {
                        isEditing = true
                    }
                    .foregroundColor(Theme.matterOrange)
                    .fontWeight(.semibold)
                }
            }
        }
        .onChange(of: selectedPhoto) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    profileImage = Image(uiImage: uiImage)
                    student.imageName = "custom_\(student.id.uuidString)"
                }
            }
        }
    }
}

// Simple flow layout for skills tags
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.positions[index].x, y: bounds.minY + result.positions[index].y), proposal: .unspecified)
        }
    }

    struct FlowResult {
        var positions: [CGPoint] = []
        var size: CGSize = .zero

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0

            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)

                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }

                positions.append(CGPoint(x: currentX, y: currentY))
                currentX += size.width + spacing
                lineHeight = max(lineHeight, size.height)
            }

            size = CGSize(width: maxWidth, height: currentY + lineHeight)
        }
    }
}

#Preview {
    NavigationStack {
        StudentDetailView(
            student: Student(
                name: "Alex Johnson",
                imageName: "person.crop.circle.fill",
                email: "alex.johnson@example.com",
                bio: "Passionate about mobile development and user experience design. Currently learning SwiftUI and exploring new ways to create intuitive interfaces.",
                skills: ["Swift", "SwiftUI", "UI Design", "Git"],
                cohort: 1,
                phase: 3,
                gender: "Male",
                funFact: "I love hiking and photography!"
            )
        )
    }
}
