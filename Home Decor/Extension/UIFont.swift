//
//  UIFont.swift
//  Home Decor
//
//  Created by Dalynn on 12/3/25.
//

import SwiftUI

extension Font {
    static func customFont(size: CGFloat, weight: FontName = .regular) -> Font {
        .custom(weight.name, size: size)
    }
}
