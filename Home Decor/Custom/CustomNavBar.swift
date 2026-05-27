//
//  CustomNavBar.swift
//  Home Decor
//
//  Created by Dalynn on 8/26/25.
//

import SwiftUI

struct CustomNavBar: View {
    var title: String = ""
    var tinhColor: Color?
    var background: Color? = Color.appBackground
    var trailingBtnIcon: String?
    var isBack: Bool = true
    var isScaleTitle: Bool = false
    var isShadow: Bool = false
    var action: (() -> Void)?
    var actionTrailingIcon: (() -> Void)?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack(spacing: 10) {
            if isBack {
                Button(action: {
                    if action == nil {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        action?()
                    }
                }, label: {
                    Image(.arrowLeft)
                        .resizable()
                        .contentShape(Rectangle())
                        .frame(width: 30, height: 30)
                })
            }
            Spacer(minLength: 0)
            
            if let trailing = trailingBtnIcon {
                Button {
                    actionTrailingIcon?()
                } label: {
                    Image(systemName: trailing)
                        .resizable()
                        .foregroundStyle(UserPreference.shared.highlightColor.color)
                        .frame(width: 24, height: 24)
                }
            }
        }
        .overlay(
            TextSwifUI(title: title,
                       size: .large,
                       color: tinhColor ?? Color.authBg,
                       weight: .bold, lineLimit: 1, isScale: isScaleTitle)
            .padding(.horizontal, 50)
        )
        .padding(.horizontal, 16)
        .frame(width: UIScreen.main.bounds.width, height: 46)
        .frame(maxWidth: .infinity)
        .shadow(color: isShadow ? .black.opacity(0.1) : .clear, radius: 4, x: 0, y: 4)
        .background(background.ignoresSafeArea())
        .frame(width: UIScreen.main.bounds.width)
        .navigationBarBackButtonHidden(true)
    }
}
