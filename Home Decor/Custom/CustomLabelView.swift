//
//  CustomLabelView.swift
//  LMS-iOS
//
//  Created by Sok Pich on 2/17/25.
//
import SwiftUI

struct CustomLabelView: View {
    var leadingText: String
    var leadingSize: FontSize = .medium
    var leadingColor: Color = .commonText
    var leadingWeight: FontName = .semiBold
    
    var trailingText: String = ""
    var trailingSize: FontSize = .normal
    var trailingColor: Color = .personalText
    var trailingWeight: FontName = .medium
    var body: some View {
        HStack {
            TextSwifUI(title: leadingText, size: leadingSize, weight: leadingWeight)
            Spacer()
            TextSwifUI(title: trailingText, size: trailingSize, color: trailingColor, weight: trailingWeight)
        }
    }
}

