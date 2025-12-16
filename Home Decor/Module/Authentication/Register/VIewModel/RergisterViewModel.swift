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
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    func register(completion: @escaping () -> Void) {
        errorMessage = ""

        guard !fullName.isEmpty else { errorMessage = "Full name is required"; return }
        guard email.contains("@") else { errorMessage = "Invalid email"; return }
        guard password.count >= 6 else { errorMessage = "Password must be at least 6 characters"; return }
        guard password == confirmPassword else { errorMessage = "Passwords do not match"; return }

        isLoading = true

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            DispatchQueue.main.async {
                self.isLoading = false
                
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    Utilize.shared.showAlert(message: self.errorMessage)
                    return
                }
                
                guard let user = result?.user else { return }
                
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = self.fullName
                changeRequest.commitChanges()
                
                let loginData = LoginDataModel(
                    id: nil,
                    email: user.email,
                    createdAt: user.metadata.creationDate?.description
                )
                
                UserPreference.shared.saveLoginData(loginData)
                
                self.isLoggedIn = true
                completion()
            }
        }
    }
    
    /// Disable button if any required field is empty
    func isValidateButton() -> Bool {
        return fullName.isEmpty ||
               email.isEmpty ||
               password.isEmpty ||
               confirmPassword.isEmpty
    }
}
