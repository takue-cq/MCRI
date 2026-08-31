import Foundation

struct APIConfig {
    // Update this URL to match your backend server address
    // For local development: http://localhost:3000
    // For production: your actual server URL
    static let baseURL = "http://localhost:3000/api"
    
    static let studentsEndpoint = "\(baseURL)/students"
    
    static func studentEndpoint(id: String) -> String {
        "\(studentsEndpoint)/\(id)"
    }
    
    static func cohortEndpoint(cohort: Int) -> String {
        "\(studentsEndpoint)/cohort/\(cohort)"
    }
}
