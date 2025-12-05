//
//  Untitled.swift
//  Home Decor
//
//  Created by Dalynn on 12/4/25.
//

import SwiftUI

struct RegisterView:View {
    @StateObject var registerVM = RergisterViewModel()
    @State var maxLimitChar: Int = maxLimitEmail
    @State var keyboardtype: UIKeyboardType = .emailAddress
    @State var isNavfromRegisterToLogin: Bool = false
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 22) {
                    TextSwifUI(title: "Create Account", size: .other(30), color: .main, weight: .bold)
                    TextSwifUI(title: "Please enter your details to proceed.", size: .normal)
                    
                    VStack(alignment: .leading, spacing: 24) {
                        MaterialTextField(text: $registerVM.email,
                                          placeholder: "Full Name",
                                          keyboardType: keyboardtype,
                                          fieldtype: .email,
                                          isDisable: false,
                                          isError: false,
                                          errorText: "",
                                          backgroundColor: .lightOrange.opacity(0.5),
                                          isAutoCapitalize: .none
                        )
                        MaterialTextField(text: $registerVM.email,
                                          placeholder: "Email",
                                          keyboardType: keyboardtype,
                                          fieldtype: .emailOrPhone,
                                          isDisable: false,
                                          isError: false,
                                          errorText: "",
                                          backgroundColor: .lightOrange.opacity(0.5),
                                          isAutoCapitalize: .none
                        )
                        MaterialTextField(text: $registerVM.email,
                                          placeholder: "Mobile Number",
                                          keyboardType: keyboardtype,
                                          fieldtype: .emailOrPhone,
                                          isDisable: false,
                                          isError: false,
                                          errorText: "",
                                          backgroundColor: .lightOrange.opacity(0.5),
                                          isAutoCapitalize: .none
                        )
                        MaterialTextField(text: $registerVM.email,
                                          placeholder: "Date of Birth",
                                          keyboardType: keyboardtype,
                                          fieldtype: .emailOrPhone,
                                          isDisable: false,
                                          isError: false,
                                          errorText: "",
                                          backgroundColor: .lightOrange.opacity(0.5),
                                          isAutoCapitalize: .none
                        )
                        MaterialTextField(text: $registerVM.password,
                                          placeholder: "Password",
                                          charLimit: maxLimitPassowrd,
                                          fieldtype: .password,
                                          backgroundColor: .lightOrange.opacity(0.5),
                                          isAutoCapitalize: .none
                        )
                        MaterialTextField(text: $registerVM.comformPassword,
                                          placeholder: "Confirm Password",
                                          charLimit: maxLimitPassowrd,
                                          fieldtype: .password,
                                          backgroundColor: .lightOrange.opacity(0.5),
                                          isAutoCapitalize: .none
                        )
                    }
                    CustomButton(title: "Sign Up", isDisabled: registerVM.isValidateButton()) {
                        registerVM.register()
                    }
                    HStack {
                        Spacer()
                        TextSwifUI(title: "Already havea an account?")
                        Button {
                            isNavfromRegisterToLogin = true
                        } label: {
                            TextSwifUI(title: "Login", color: .main)
                        }
                        Spacer()
                    }
                }
            }
        }
        .padding(.all, 12)
        .navigationDestination(isPresented: $isNavfromRegisterToLogin) {
            LoginView()
        }
    }
}
