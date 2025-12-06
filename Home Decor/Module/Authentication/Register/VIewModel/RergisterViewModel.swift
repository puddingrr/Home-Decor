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
        
        // VALIDATION
        if fullName.isEmpty {
            errorMessage = "Full name is required"
            return
        }
        
        if email.isEmpty {
            errorMessage = "Email is required"
            return
        }
        
        if mobileNumber.isEmpty {
            errorMessage = "Mobile number is required"
            return
        }
        
        if dateOfBirth.isEmpty {
            errorMessage = "Date of birth is required"
            return
        }
        
        if password.isEmpty {
            errorMessage = "Password is required"
            return
        }
        
        if password != confirmPassword {
            errorMessage = "Passwords do not match"
            return
        }
        
        isLoading = true
        
        // FIREBASE REGISTER
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
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
