//
//  Color.swift
//  InfoWebiOS
//
//  Created by Chhan dalyn on 15/1/25.
//

import Foundation
import UIKit
import SwiftUI

extension Color {
    // MARK: Main Tab Bar
    static let seetingBg = Color(red: 0.971, green: 0.971, blue: 0.971)
    static let brandOrange = Color(red: 0.91, green: 0.25, blue: 0.16)
    static let brandYellow = Color(red: 0.91, green: 0.63, blue: 0.13)
    static let fieldBackground = Color(UIColor.systemBackground)
    static let pageBackground = Color(UIColor.systemGroupedBackground)
    
    init(hex: String) {
           let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
           var int: UInt64 = 0
           Scanner(string: hex).scanHexInt64(&int)
           let r = Double((int >> 16) & 0xFF) / 255
           let g = Double((int >> 8) & 0xFF) / 255
           let b = Double(int & 0xFF) / 255
           self.init(red: r, green: g, blue: b)
       }
}
