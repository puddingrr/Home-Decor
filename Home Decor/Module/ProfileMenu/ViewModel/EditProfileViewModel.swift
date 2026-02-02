//
//  EditProfileViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 12/18/25.
//

import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class EditProfileViewModel: ObservableObject {
    @Published var list: [ProfileIconModel] = []
    @Published var imageURLs: [String: URL] = [:]
    @Published var fullName: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var isLoading = false
    @Published var errorMessage = ""
    @Published var selectedProfileImageURL: String?

    private var profileVM: ProfileViewModel?

    init(profileVM: ProfileViewModel? = nil) {
        self.profileVM = profileVM
        loadCurrentUser()
    }

    func loadCurrentUser() {
        guard let user = Auth.auth().currentUser else { return }
        self.fullName = user.displayName ?? ""
        self.email = user.email ?? ""
    }

    func updateProfile(completion: @escaping () -> Void) {
        guard let user = Auth.auth().currentUser else { return }
        isLoading = true
        errorMessage = ""

        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = fullName
        changeRequest.commitChanges { error in
            if let error = error {
                self.handleError(error)
                return
            }

            if self.email != user.email {
                user.sendEmailVerification(beforeUpdatingEmail: self.email) { error in
                    if let error = error {
                        self.handleError(error)
                        return
                    }
                }
            }

            if !self.password.isEmpty {
                guard self.password == self.confirmPassword else {
                    self.handleErrorMessage("Passwords do not match")
                    return
                }
                user.updatePassword(to: self.password) { error in
                    if let error = error {
                        self.handleError(error)
                        return
                    }
                }
            }

            // Save to UserDefaults
            let updatedUser = LoginDataModel(
                id: nil,
                email: user.email,
                createdAt: user.metadata.creationDate?.description,
                fullName: user.displayName
            )
            UserPreference.shared.saveLoginData(updatedUser)

            // Update ProfileViewModel directly
            DispatchQueue.main.async {
                self.profileVM?.refreshUser(updatedUser)
                self.isLoading = false
                Utilize.shared.showAlert(message: "Profile updated successfully")
                completion()
            }
        }
    }

    private func handleError(_ error: Error) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMessage = error.localizedDescription
            Utilize.shared.showAlert(message: self.errorMessage)
        }
    }

    private func handleErrorMessage(_ message: String) {
        DispatchQueue.main.async {
            self.isLoading = false
            self.errorMessage = message
            Utilize.shared.showAlert(message: message)
        }
    }
    func isValidateButtonEdit() -> Bool {
        return fullName.isEmpty ||
               email.isEmpty ||
               password.isEmpty ||
               confirmPassword.isEmpty
    }
    
    func saveProfileImage(url: String) async {
        guard let uid = Auth.auth().currentUser?.uid else { return }

        do {
            try await Firestore.firestore()
                .collection("users")
                .document(uid)
                .updateData([
                    "profileImageUrl": url
                ])

            await MainActor.run {
                self.selectedProfileImageURL = url
            }

        } catch {
            print("❌ Failed to save profile image:", error.localizedDescription)
        }
    }


    func fetchIcons() {
        Task {
            do {
                let snapshot = try await Firestore.firestore()
                    .collection("products") // must match seeder
                    .getDocuments()

                let icons = snapshot.documents.map { doc in
                    ProfileIconModel(
                        id: doc.documentID,
                        imageURLs: doc["imageURLs"] as? [String] ?? []
                    )
                }

                await MainActor.run {
                    self.list = icons
                }
            } catch {
                print("❌ Firestore error:", error.localizedDescription)
            }
        }
    }
}
