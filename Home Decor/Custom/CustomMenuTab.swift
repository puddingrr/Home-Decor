//
//  CustomMenuTab.swift
//  Home Decor
//
//  Created by Dalynn on 12/11/25.
//
import SwiftUI

struct CustomMenuTab: View {
//    @Binding var isLoginRequired: Bool
    @Binding var index: Int?
    var items: [String]
    var textColor: Color = Color.gray
    var textColorselected: Color = Color.selectPink
    var body: some View {
        HStack(spacing: 16) {
            ForEach(0..<items.count, id: \.self) { i in
                Button {
                    withAnimation {
                        index = i
                    }
                } label: {
                    VStack {
                        TextSwifUI(title: items[i], size: .other(16),
                                   color: index == i ? textColorselected : textColor, weight: index == i ? .bold : .medium)
                            .frame(maxWidth: .infinity)
                        if index == i {
                            Rectangle()
                                .fill(textColorselected)
                                .frame(width: 40, height: 2)
                        }
                    }
                }
            }
        }
    }
}

