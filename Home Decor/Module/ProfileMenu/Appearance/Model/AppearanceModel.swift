//
//  AppearanceModel.swift
//  Home Decor
//
//  Created by Dalynn on 2/3/26.
//

import SwiftUI

enum ThemeColor: String, CaseIterable {
    case blue
    case red
    case green
    case purple
    case orange
    case pink
    case teal

    var color: Color {
        switch self {
        case .blue:   return .blue
        case .red:    return .red
        case .green:  return .green
        case .purple: return .purple
        case .orange: return .orange
        case .pink:   return .pink
        case .teal:   return .teal
        }
    }
}
