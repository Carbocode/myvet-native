// AppearanceMode.swift
import SwiftUI

enum AppearanceMode: String, CaseIterable, Identifiable {
    case system = "Automatico"
    case light = "Chiara"
    case dark = "Scura"

    var id: String { self.rawValue }

    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
