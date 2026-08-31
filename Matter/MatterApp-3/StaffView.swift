import SwiftUI

struct StaffView: View {
    @State private var staff: [Staff] = []
    @State private var showingAddStaffSheet = false
    @State private var staffToDelete: Staff?

    var body: some View {
        ZStack {
            IconGridBackground()

            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    MatterHeader(title: "Staff", subtitle: "Meet the Matter team")
                        .overlay(alignment: .topTrailing) {
                            Button {
                                showingAddStaffSheet = true
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundColor(Theme.textWhite)
                            }
                        }

                    ForEach(staff) { staffMember in
                        HStack(spacing: 14) {
                            Image(systemName: staffMember.imageName)
                                .font(.system(size: 30))
                                .foregroundColor(Theme.textWhite.opacity(0.85))

                            VStack(alignment: .leading, spacing: 4) {
                                Text(staffMember.name)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Theme.textPrimary)
                                Text(staffMember.role)
                                    .font(.system(size: 14))
                                    .foregroundColor(Theme.textSecondary)
                            }

                            Spacer()

                            Button {
                                staffToDelete = staffMember
                            } label: {
                                Image(systemName: "trash.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(Theme.textWhite.opacity(0.6))
                            }
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
        .sheet(isPresented: $showingAddStaffSheet) {
            AddStaffView()
        }
        .alert("Delete Staff", isPresented: .constant(staffToDelete != nil)) {
            Button("Cancel", role: .cancel) {
                staffToDelete = nil
            }
            Button("Delete", role: .destructive) {
                if let staffToDelete = staffToDelete {
                    StaffRepository.shared.deleteStaff(byId: staffToDelete.id)
                    loadStaff()
                }
                staffToDelete = nil
            }
        } message: {
            if let staffToDelete = staffToDelete {
                Text("Are you sure you want to delete \(staffToDelete.name)?")
            }
        }
        .onAppear {
            loadStaff()
        }
    }

    private func loadStaff() {
        staff = StaffRepository.shared.getAllStaff()
    }
}

#Preview {
    NavigationStack { StaffView() }
}
