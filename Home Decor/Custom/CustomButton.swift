//
//  CustomButton.swift
//  KKDollar-iOS
//
//  Created by Bhadresh on 11/08/23.
//

import SwiftUI

// MARK: - Custom Button
struct CustomButton: View {
    var title: String
    var icon: ImageResource?
    var isOutline: Bool = false
    var backgroundImage: String?
    var font: FontSize = .normal
    var textColor: Color = .white
    var lineLimit: Int?
    var width: CGFloat?
    var height: CGFloat = 45
    var radius: CGFloat = 12
    var bgColor: Color = .main
    var isDisabled: Bool = false
    var isFromWebView: Bool = false
    var action: () -> Void = {Utilize.hideKeyboard()}
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
                if let icon = icon {
                    Image(icon)
                        .resizable()
                        .frame(width: 22, height: 22)
                }
                Text(title)
                    .font(.system(size: font.fontSize))
                    .foregroundColor(isOutline ? .main : textColor)
                    .minimumScaleFactor(0.5)
                    .lineLimit(lineLimit)
            }
            .frame(minWidth: 0, maxWidth: width ?? .infinity)
            .frame(height: height)
            .padding(.horizontal, 5)
            .background(
                RoundedRectangle(cornerRadius: radius)
                    .stroke(isOutline ? Color.main : Color.clear, lineWidth: 1)
            )
            .background(isDisabled ? .selectPink.opacity(0.5) : .selectPink)
            .cornerRadius(radius)
        }
        .disabled(isDisabled)
    }
}

struct CircleButton: View {
    var action: () -> Void
    var isShow: Bool
    var body: some View {
        if isShow {
            Button {
                action()
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.main)
                    Image(systemName: "chevron.up")
                        .tint(Color.white)
                }
                .frame(width: 50, height: 50)
            }
        }
    }
}
