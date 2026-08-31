import SwiftUI

struct Student: Identifiable, Codable {
    let id: UUID
    var name: String
    var imageName: String
    var email: String
    var bio: String
    var skills: [String]
    let cohort: Int
    var phase: Int // Current phase (1-6)
    var gender: String
    var funFact: String
    
    init(id: UUID = UUID(), name: String, imageName: String, email: String, bio: String, skills: [String], cohort: Int, phase: Int, gender: String, funFact: String) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.email = email
        self.bio = bio
        self.skills = skills
        self.cohort = cohort
        self.phase = phase
        self.gender = gender
        self.funFact = funFact
    }
}
