import SwiftUI

enum Theme {
    // Brand burnt-orange from the Matter splash/header screens
    static let matterOrange = Color(red: 0.82, green: 0.38, blue: 0.18)
    static let matterOrangeDark = Color(red: 0.70, green: 0.30, blue: 0.13)
    
    // Text colors with better contrast
    static let textWhite = Color.white
    static let textPrimary = Color(red: 1.0, green: 1.0, blue: 1.0) // Pure white for primary text
    static let textSecondary = Color(red: 0.95, green: 0.95, blue: 0.95) // Slightly dimmed white
    static let textTertiary = Color(red: 0.85, green: 0.85, blue: 0.85) // More dimmed for subtitles
    
    // Background colors for better contrast
    static let backgroundLight = Color(red: 0.98, green: 0.98, blue: 0.98)
    static let cardBackground = Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.95)
    static let inputBackground = Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.98)
}
