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
    @Published var errorMessage: String = "Email or Password is incorrect"
    @Published var isNavigate = false

    func login(completion: @escaping (_ user: User) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                Utilize.shared.showAlert(message: self.errorMessage)
                print("🔥 Firebase Auth Error:", error)
                return
            }
            
            if let user = result?.user {
                self.isLoggedIn = true
                let loginData = LoginDataModel(
                    id: nil,
                    email: user.email,
                    createdAt: user.metadata.creationDate?.description
                )
                
                // Save user login info
                UserPreference.shared.saveLoginData(loginData)
                completion(user)
            }
        }
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
    func checkValidateTextField() -> Bool {
        if email.isValidEmail() == false {
            errorMessage = "Email Address is incorrect"
            return false
        } else {
            errorMessage = ""
            return true
        }
    }
}
