//
//  RergisterViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 12/4/25.
//
import Foundation
import FirebaseAuth

class RergisterViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var mobileNumber: String = ""
    @Published var dateOfBirth: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    func register() {
        errorMessage = ""

        guard !fullName.isEmpty else { errorMessage = "Full name is required"; return }
        guard email.contains("@") else { errorMessage = "Invalid email"; return }
        guard password.count >= 6 else { errorMessage = "Password must be at least 6 characters"; return }
        guard password == confirmPassword else { errorMessage = "Passwords do not match"; return }

        isLoading = true

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false

                if error != nil {
                    Utilize.shared.showAlert(message: self.errorMessage)
                    return
                }

                if let user = result?.user {
                    let changeRequest = user.createProfileChangeRequest()
                    changeRequest.displayName = self.fullName
                    changeRequest.commitChanges()
                }

                self.isLoggedIn = true
            }
        }
    }
    
    /// Disable button if any required field is empty
    func isValidateButton() -> Bool {
        return fullName.isEmpty ||
        email.isEmpty ||
        mobileNumber.isEmpty ||
        dateOfBirth.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty
    }
}
