//
//  UIFont.swift
//  Home Decor
//
//  Created by Dalynn on 12/3/25.
//

import SwiftUI

extension Font {
    static func customFont(
        size: CGFloat,
        weight: Font.Weight = .regular,
        fontName: String = "Roboto"
    ) -> Font {
        return Font.custom(fontName, size: size).weight(weight)
    }
}
