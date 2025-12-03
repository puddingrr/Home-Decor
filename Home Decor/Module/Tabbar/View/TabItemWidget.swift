//
//  TabItemWidget.swift
//  Home Decor
//
//  Created by Dalynn on 8/25/25.
//
import SwiftUI

struct TabItemWidget: View {
    var icon, activeIcon: ImageResource
    var isSelected: Bool
    var namespace: Namespace.ID 
    var action: () -> Void

    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.3)) {
                action()
            }
        } label: {
            VStack {
                Image(isSelected ? activeIcon : icon)
                    .resizable()
                    .frame(width: 24, height: 24)

                if isSelected {
                    Color.black
                        .frame(width: 30, height: 2)
                        .matchedGeometryEffect(id: "underline", in: namespace)
                }
            }
            .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
            .cornerRadius(12)
        }
    }
}

struct TabItemModel {
    let icon, activeIcon: ImageResource
}
