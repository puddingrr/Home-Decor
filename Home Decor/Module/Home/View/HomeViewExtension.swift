//
//  HomeViewExtension.swift
//  Home Decor
//
//  Created by Dalynn on 2/2/26.
//

import SwiftUI

extension HomeView {
    var panelAuthView: some View {
        HStack {
            if !viewModel.isLoggedIn {
                HStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 26, height: 26)
                    TextSwifUI(title: "NotLoggedIn", color: Color.authTitle)
                    Spacer()
                    CustomButton(title: "Login", width: 80, height: 30) {
                        viewModel.navType = .login
                        viewModel.isHomeNavigation = true
                    }
                    CustomButton(title: "SignUp", width: 80, height: 30) {
                        viewModel.navType = .register
                        viewModel.isHomeNavigation = true
                    }
                }
                .padding(.horizontal, 16)
                .frame(height: 50)
//                .padding(.bottom, viewModel.isLoggedIn == false ? 50 : 0)
                .background(Color.authBg)
            }
        }
    }
}
