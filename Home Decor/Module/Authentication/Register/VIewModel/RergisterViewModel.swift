//
//  RergisterViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 12/4/25.
//
import Foundation
import FirebaseAuth

class RergisterViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var comformPassword: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                self.errorMessage = "Error"
                return
            }
            self.isLoggedIn = true
        }
    }
    
    func isValidateButton() -> Bool {
        if email.isEmpty {
            return true
        } else if password.isEmpty {
            return true
        } else if comformPassword.isEmpty {
            return true
        } else {
            return false
        }
    }
}
