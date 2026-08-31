import SwiftUI

struct Staff: Identifiable, Codable {
    let id: UUID
    var name: String
    var role: String
    var email: String
    var bio: String
    var imageName: String
    
    init(id: UUID = UUID(), name: String, role: String, email: String, bio: String, imageName: String = "person.crop.circle.fill") {
        self.id = id
        self.name = name
        self.role = role
        self.email = email
        self.bio = bio
        self.imageName = imageName
    }
}
