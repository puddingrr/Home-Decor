//
//  View.swift
//  Home Decor
//
//  Created by Dalynn on 1/29/26.
//

import SwiftUI

struct AppearanceView: View {
    
    @AppStorage("appTheme") private var appTheme: Int = 0
    @AppStorage("highlightColor") private var highlightRaw: String = UIThemeColor.red.rawValue
    
    @State private var selectedTheme: TypeUITheme = .system
    
    private var selectedHighlight: UIThemeColor {
        UIThemeColor(rawValue: highlightRaw) ?? .red
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.appBackground.ignoresSafeArea()
            
            VStack(spacing: 0) {
                CustomNavBar(title: "App Appearance", isShadow: true)
                RoundedRectangle(cornerRadius: 0)
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.3))
                VStack(alignment: .leading) {
                    TextSwifUI(title: "Theme".uppercased(), size: .medium)
                    VStack(alignment: .leading, spacing: 16) {
                        TextSwifUI(title: "Mode", size: .medium)
                        HStack {
                            ForEach(TypeUITheme.allCases, id: \.self) { theme in
                                UIScreenView(
                                    typeUITheme: theme,
                                    isSelected: selectedTheme == theme,
                                    highlight: selectedHighlight.color
                                )
                                .frame(maxWidth: .infinity)
                                .onTapGesture {
                                    selectedTheme = theme
                                    appTheme = theme.storageValue
                                }
                            }
                        }
                        
                        Divider()
                            .padding(.vertical, 16)
                        
                        TextSwifUI(title: "Highlight Color", size: .medium)
                        HStack {
                            ForEach(UIThemeColor.allCases, id: \.self) { item in
                                Circle()
                                    .fill(item.color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        ZStack {
                                            Circle()
                                                .stroke(selectedHighlight == item ? Color.white : Color.clear, lineWidth: 2)
                                            Circle()
                                                .stroke(selectedHighlight == item ? item.color : Color.clear, lineWidth: 1)
                                                .frame(width: 37, height: 37)
                                        }
                                    )
                                    .onTapGesture {
                                        highlightRaw = item.rawValue
                                    }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity)
                    .background(Color.darkCardBG)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    )
                }
                .padding(16)
            }
        }
        .onAppear {
            switch appTheme {
            case 1:
                selectedTheme = .light
            case 2:
                selectedTheme = .dark
            default:
                selectedTheme = .system
            }
        }
    }
}

struct UIScreenView : View {
    
    let typeUITheme: TypeUITheme
    let isSelected: Bool
    let highlight: Color
    
    private let screenHeight: CGFloat = 150
    
    var body: some View {
        VStack {
            ZStack {
                backgroundView
                contentView
            }
            .padding(4)
            .cornerRadius(10)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isSelected ? highlight : .clear, lineWidth: 1)
            }
            TextSwifUI(title: typeUITheme.title)
                .padding(.top, 4)
        }
    }
}

extension UIScreenView {
    var backgroundView: some View {
        VStack(spacing: 0) {
            switch typeUITheme {
            case .light:
                Color.gray.opacity(0.1)
                    .frame(height: screenHeight * 0.4)
                Color.gray.opacity(0.01)
                    .frame(height: screenHeight * 0.6)
                
            case .dark:
                Color.gray.opacity(0.3)
                    .frame(height: screenHeight * 0.4)
                Color.black
                    .frame(height: screenHeight * 0.6)
                
            case .system:
                HStack(spacing: 0) {
                    Color.gray.opacity(0.1)
                    Color.gray.opacity(0.3)
                }
                .frame(height: screenHeight * 0.4)

                HStack(spacing: 0) {
                    Color.gray.opacity(0.01)
                    Color.black
                }
                .frame(height: screenHeight * 0.6)
            }
        }
        .frame(width: screenHeight / 2, height: screenHeight)
        .cornerRadius(10)
    }
    
    var contentView: some View {
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
            
            RoundedRectangle(cornerRadius: 2)
                .fill(isSelected ? highlight : Color.gray.opacity(0.5))
                .frame(width: screenHeight / 2.5, height: screenHeight / 10)
        }
    }
}
