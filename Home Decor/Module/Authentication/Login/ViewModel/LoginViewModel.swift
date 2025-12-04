//
//  LoginViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 12/3/25.
//

import FirebaseAuth
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = "Error"
                return
            }
            self.isLoggedIn = true
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.errorMessage = "Error"
                return
            }
            self.isLoggedIn = true
        }
    }

    func logout() {
        try? Auth.auth().signOut()
        isLoggedIn = false
    }
    func isValidateButton() -> Bool {
        if email.isEmpty {
            return true
        } else if password.isEmpty {
            return true
        } else {
            return false
        }
    }
}
