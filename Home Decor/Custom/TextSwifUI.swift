//
//  UITextfield.swift
//  Home Decor
//
//  Created by Dalynn on 8/25/25.
//

import SwiftUI

struct TextSwifUI: View {
    var title: String
    var size: CGFloat = 14
    var color: Color = .primary
    var weight: Font.Weight = .regular
    var textAlignment: TextAlignment = .leading
    var isUnderline: Bool = false
    var lineLimit: Int? = nil
    var gradientColor: LinearGradient? = nil
    var isAsterisk: Bool = false
    var isScale: Bool = true

    var body: some View {
        let displayText = isAsterisk ? "\(title)*" : title

        let text = Text(displayText)
            .font(.system(size: size, weight: weight))
            .underline(isUnderline, color: gradientColor == nil ? color : .clear)
            .multilineTextAlignment(textAlignment)
            .lineLimit(lineLimit)
            .minimumScaleFactor(isScale ? 0.5 : 1)
            .fixedSize(horizontal: false, vertical: true)

        if let gradient = gradientColor {
            text
                .foregroundColor(.clear)
                .overlay(gradient)
                .mask(
                    Text(displayText)
                        .font(.system(size: size, weight: weight))
                        .underline(isUnderline, color: .clear)
                        .multilineTextAlignment(textAlignment)
                        .minimumScaleFactor(isScale ? 0.5 : 1)
                )
        } else {
            text.foregroundColor(color)
        }
    }
}
