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
                                   color: index == i ? Color.selectPink : Color.gray, weight: index == i ? .bold : .regular)
                            .frame(maxWidth: .infinity)
                        if index == i {
                            Color.selectPink
                                .frame(width: 40, height: 2)
                        }
                    }
                }
            }
        }
    }
}

