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
    var tabInclude: String = "3"
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<items.count, id: \.self) { i in
                Button {
                    withAnimation {
                        index = i
                    }
                } label: {
                    VStack {
                        let title = items[i]
                        TextSwifUI(title: (i == 1) && !tabInclude.isEmpty ? "\(title)\(tabInclude)" : title, size: .normal, color: index == i ? Color.selectPink : Color.gray)
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

