//
//  AppearanceModel.swift
//  Home Decor
//
//  Created by Dalynn on 2/3/26.
//

import SwiftUI

enum TypeUITheme: CaseIterable {
    case light
    case dark
    case system
    
    var title: String {
        switch self {
        case .light: return "Light"
        case .dark: return "Dark"
        case .system: return "System"
        }
    }
    
    var storageValue: Int {
        switch self {
        case .system: return 0
        case .light: return 1
        case .dark: return 2
        }
    }
}

enum UIThemeColor: String, CaseIterable, Equatable {
    case red, yellow, lightPurple, lightBlue, lightGreen, orange, pink, teal
    
    var color: Color {
        switch self {
        case .red: return .main
        case .yellow: return .yellow
        case .lightPurple: return .lightPurple
        case .lightBlue: return .lightBlue
        case .lightGreen: return .lightGreen
        case .orange: return .orange
        case .pink: return .pink
        case .teal:   return .teal
        }
    }
}
