//
//  View.swift
//  Home Decor
//
//  Created by Dalynn on 1/29/26.
//

import SwiftUI

struct AppearanceView: View {
    
    @AppStorage("appTheme") private var appTheme: Int = 0
    
     var isDarkMode: Bool {
        switch appTheme {
        case 2:
            return true
        case 1:
            return false
        default:
            return UITraitCollection.current.userInterfaceStyle == .dark
        }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                CustomNavBar(title: "App Appearance", isShadow: true)
                VStack(alignment: .leading) {
                    TextSwifUI(title: "Theme", size: .medium)
                    VStack(alignment: .leading) {
                        TextSwifUI(title: "Mode", size: .medium)
                        HStack {
                            UIScreenView(typeUITheme: .light)
                                .frame(maxWidth: .infinity)
                            UIScreenView(typeUITheme: .dark)
                                .frame(maxWidth: .infinity)
                            UIScreenView(isSelected: true, typeUITheme: .system)
                                .frame(maxWidth: .infinity)
                        }
                        Divider()
                        TextSwifUI(title: "Highlight Color", size: .medium)
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    )
                }
                .padding(16)
            }
        }
    }
}

struct UIScreenView : View {
    
//    let item: UIThemeColor
//    let selected: UIThemeColor?
    var isSelected: Bool = false
    var typeUITheme: TypeUITheme = .system
    
    private let screenHeight: CGFloat = 150
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                ZStack {
                    VStack(spacing: 0) {
                        if typeUITheme == .light {
                            Color.gray.opacity(0.1)
                                .frame(width: screenHeight / 2, height: screenHeight * 0.4)
                            
                            Color.gray.opacity(0.001)
                                .frame(width: screenHeight / 2, height: screenHeight * 0.6)
                        } else if typeUITheme == .dark {
                            Color.gray.opacity(0.3)
                                .frame(width: screenHeight / 2, height: screenHeight * 0.4)
                            
                            Color.black
                                .frame(width: screenHeight / 2, height: screenHeight * 0.6)
                        } else {
                            HStack(spacing: 0) {
                                Color.gray.opacity(0.1)
                                    .frame(width: screenHeight / 4, height: screenHeight * 0.4)
                                
                                Color.gray.opacity(0.3)
                                    .frame(width: screenHeight / 4, height: screenHeight * 0.4)
                            }
                            HStack(spacing: 0) {
                                Color.gray.opacity(0.01)
                                    .frame(width: screenHeight / 4, height: screenHeight * 0.6)
                                
                                Color.black
                                    .frame(width: screenHeight / 4, height: screenHeight * 0.6)
                            }
                        }
                    }
                    .cornerRadius(5)
                    .frame(height: screenHeight)
                    
                    VStack(spacing: 32) {
                        VStack(spacing: 2) {
                            RoundedRectangle(cornerRadius: 2)
                                .foregroundColor(Color.gray.opacity(0.5))
                                .frame(width: screenHeight / 3.5 , height: screenHeight / 15)
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.gray.opacity(0.5))
                                .frame(width: screenHeight / 6, height: screenHeight / 25)
                        }
                        
                        HStack(spacing: 3) {
                            ForEach(0..<5) { _ in
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.gray.opacity(0.5))
                                    .frame(width: screenHeight / 20, height: screenHeight / 20)
                            }
                        }
                        .padding(.horizontal, 3)
                        .padding(.top, 10)
                        
                        RoundedRectangle(cornerRadius: 2)
                            .foregroundColor(isSelected ? Color.purple : Color.gray.opacity(0.5))
                            .frame(width: screenHeight / 2.5, height: screenHeight / 10)
                            .padding(.top, 10)
                    }
                }
                .padding(4)
            }
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? Color.purple : Color.clear, lineWidth: 1)
            }
            TextSwifUI(title: typeUITheme.title)
                .padding(.top, 4)
        }
    }
}

enum TypeUITheme {
    case dark
    case light
    case system
    
    var title: String {
        switch self {
        case .dark: return "Dark"
        case .light: return "Light"
        case .system: return "System"
        }
    }
}

enum UIThemeColor: CaseIterable, Equatable {
    case red, blue, green, yellow, purple, clear

    var color: Color {
        switch self {
        case .red: return .red
        case .blue: return .blue
        case .green: return .green
        case .yellow: return .yellow
        case .purple: return .purple
        case .clear: return .clear
        }
    }
}
