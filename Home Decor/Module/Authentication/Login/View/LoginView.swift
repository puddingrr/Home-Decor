//
//  LoginView.swift
//  Home Decor
//
//  Created by Dalynn on 12/3/25.
//

import SwiftUI

struct LoginView:View {
    @StateObject var loginVM = LoginViewModel()
    //State
    @State var maxLimitChar: Int = maxLimitEmail
    @State var keyboardtype: UIKeyboardType = .emailAddress
    @State var isNavfromLoginToRegister: Bool = false
    @State var isRememberMe: Bool = false
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    TextSwifUI(title: "Log In", size: .other(30), color: .main, weight: .bold)
                    TextSwifUI(title: "Welcome", size: .medium, weight: .bold)
                    TextSwifUI(title: "Please enter your details to proceed.", size: .normal)
                    
                    
                    VStack(alignment: .leading, spacing: 24) {
                        MaterialTextField(text: $loginVM.email,
                                          placeholder: "Username or email",
                                          keyboardType: keyboardtype,
                                          fieldtype: .emailOrPhone,
                                          isDisable: false,
                                          isError: false,
                                          errorText: "",
                                          backgroundColor: .lightOrange.opacity(0.5),
                                          isAutoCapitalize: .none
                        )
                        MaterialTextField(text: $loginVM.password,
                                          placeholder: "Password",
                                          charLimit: maxLimitPassowrd,
                                          fieldtype: .password,
                                          backgroundColor: .lightOrange.opacity(0.5),
                                          isAutoCapitalize: .none
                        )
                    }
                    HStack {
                        Button {
                            isRememberMe.toggle()
                        } label: {
                            Image(isRememberMe ? .remembermeActive : .remembermeIcon)
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                        TextSwifUI(title: "Remember Me", size: .medium, color: .gray.opacity(0.7))
                        Spacer()
                    }
                    CustomButton(title: "Login", isDisabled: loginVM.isValidateButton()) {
                        loginVM.login()
                    }
                    HStack {
                        Spacer()
                        TextSwifUI(title: "Don’t have an account?")
                        Button {
                            isNavfromLoginToRegister = true
                        } label: {
                            TextSwifUI(title: "Sign Up", color: .main)
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding(.all, 12)
        .navigationDestination(isPresented: $isNavfromLoginToRegister) {
            RegisterView()
        }
    }
}
