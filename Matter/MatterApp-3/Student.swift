import SwiftUI

struct Student: Identifiable {
    let id = UUID()
    var name: String
    var imageName: String
    var email: String
    var bio: String
    var skills: [String]
    let cohort: Int
    var phase: Int // Current phase (1-6)
    var gender: String
    var funFact: String
}
