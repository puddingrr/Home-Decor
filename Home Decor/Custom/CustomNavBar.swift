//
//  CustomNavBar.swift
//  Home Decor
//
//  Created by Dalynn on 8/26/25.
//

import SwiftUI

struct CustomNavBar: View {
    var title: String = ""
    var tinhColor: Color = Color.selectPink
    var background: Color?
    var trailingBtnIcon: ImageResource?
    var isBack: Bool = true
    var action: (() -> Void)?
    var actionLogin: (() -> Void)?
    var actionTrailingIcon: (() -> Void)?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                if isBack {
                    Button(action: {
                        if action == nil {
                            presentationMode.wrappedValue.dismiss()
                        } else {
                            action?()
                        }
                    }, label: {
                        Image(.backIcon)
                            .resizable()
                            .contentShape(Rectangle())
                            .frame(width: 19, height: 16)
                    })
                }
                Spacer(minLength: 0)
                
                if let trailing = trailingBtnIcon {
                    Button {
                        actionTrailingIcon?()
                    } label: {
                        Image(trailing)
                            .resizable()
                            .contentShape(Rectangle())
                            .frame(width: 24, height: 24)
                    }
                }
            }
            .overlay(
                TextSwifUI(title: title,
                           size: .huge,
                           color: tinhColor,
                            weight: .bold, lineLimit: 1)
                .padding(.horizontal, 50)
            )
            .padding(.horizontal, 16)
            .frame(width: UIScreen.main.bounds.width, height: 38)
            .frame(maxWidth: .infinity)
        }
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
        .background(background.ignoresSafeArea())
        .frame(width: UIScreen.main.bounds.width)
        .navigationBarBackButtonHidden(isBack)
    }
}
