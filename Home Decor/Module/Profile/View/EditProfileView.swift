//
//  EditProfile.swift
//  Home Decor
//
//  Created by Dalynn on 8/28/25.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    @State private var mediaType: MediaPicker.MediaType?
    @StateObject var editVM = EditProfileViewModel()
    @State var keyboardtype: UIKeyboardType = .emailAddress
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            CustomNavBar(title: "My Profile", tinhColor: .main)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    Button {
                        viewModel.showPortraitSheet = true
                    } label: {
                        ZStack {
                            if let urlString = editVM.selectedProfileImageURL,
                               let url = URL(string: urlString) {

                                AsyncImage(url: url) { img in
                                    img.resizable().scaledToFill()
                                } placeholder: {
                                    Circle().fill(Color.gray.opacity(0.3))
                                }
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())

                            } else if let image = viewModel.localProfileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())

                            } else {
                                Circle()
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(width: 100, height: 100)
                            }
                            Image(.editProfile)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 31, height: 31)
                                .background(Color.gray)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .offset(x: 31, y: 31)
                        }
                    }
                    VStack {
                        TextSwifUI(title: editVM.fullName, size: .large, weight: .bold)
                    }
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.lightOrange)
                }
                
                VStack(alignment: .leading, spacing: 22) {
                    MaterialTextField(
                        text: $editVM.fullName,
                        placeholder: "Full Name",
                        backgroundColor: .lightOrange
                    )

                    MaterialTextField(
                        text: $editVM.email,
                        placeholder: "Email",
                        keyboardType: .emailAddress,
                        backgroundColor: .lightOrange
                    )

                    MaterialTextField(
                        text: $editVM.password,
                        placeholder: "New Password",
                        fieldtype: .password,
                        backgroundColor: .lightOrange
                    )

                    MaterialTextField(
                        text: $editVM.confirmPassword,
                        placeholder: "Confirm Password",
                        fieldtype: .password,
                        backgroundColor: .lightOrange
                    )
                    .padding(.top, 8)
                    
                    TextSwifUI(title: "Gender")
                        .padding(.top, 8)
                    
                    HStack {
                        HStack {
                            Image(.nonSelected)
                                .resizable()
                                .frame(width: 15, height: 15)
                            TextSwifUI(title: "Male")
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(Color.lightOrange.cornerRadius(14))
                        HStack {
                            Image(.isSelected)
                                .resizable()
                                .frame(width: 15, height: 15)
                            TextSwifUI(title: "Female")
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(Color.lightOrange.cornerRadius(14))
                    }
                }
                .padding(16)
                // MARK: - Update Button
               
                CustomButton(title: "Update Profile", width: 120, isDisabled: editVM.isValidateButtonEdit()) {
                    editVM.updateProfile {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                
            }
            Spacer()
        }
        .sheet(isPresented: $viewModel.showPortraitSheet) {
            ProfileIconView(viewModel: editVM) { selectedURL in
                Task {
                    await editVM.saveProfileImage(url: selectedURL)
                    viewModel.profileImageUrl = selectedURL // ⭐ update main VM
                    viewModel.showPortraitSheet = false
                }
            }
        }
//        .fullScreenCover(isPresented: $viewModel.showPortraitSheet) {
//            MediaPicker(mediaType: $mediaType, selectedMedia: $viewModel.localProfileImage, selectedFileURLs: $viewModel.selectedFileURLs, isSingleSelection: true)
//                .ignoresSafeArea()
//        }
//        .actionSheet(isPresented: $viewModel.showPortraitSheet) {
//            ActionSheet(
//                title: Text("Choose Optione"),
//                buttons: [
//                    .cancel(Text("Cancel")) {},
//                    .default(
//                        Text("Gallery"),
//                        action: {
//                            mediaType = .gallery
//                            viewModel.showGalarryPicker.toggle()
//                        }
//                    ),
//                    .default(
//                        Text("Camera"),
//                        action: {
//                            mediaType = .camera
//                            viewModel.showCameraPicker.toggle()
//                        }
//                    )
//                ]
//            )
//        }
//        .sheet(isPresented: $viewModel.showGalarryPicker) {
//            MediaPicker(mediaType: $mediaType, selectedMedia: $viewModel.localProfileImage, selectedFileURLs: $viewModel.selectedFileURLs, isSingleSelection: true)
//        }
//        .fullScreenCover(isPresented: $viewModel.showCameraPicker) {
//            MediaPicker(mediaType: $mediaType, selectedMedia: $viewModel.localProfileImage, selectedFileURLs: $viewModel.selectedFileURLs, isSingleSelection: true)
//                .ignoresSafeArea()
//        }
//        .onChange(of: viewModel.localProfileImage) { newImage in
//            if let image = newImage {
//                viewModel.uploadProfile(profileImage: image)
//            }
//        } 
//        .onDisappear {
//            if viewModel.isProfileUploaded {
//                viewModel.isProfileUploaded = false
//            }
//        }
    }
    @ViewBuilder
    func textfield(title: String, text: String) -> some View {
        
    }
}

struct TextfieldList {
    let title, subTittle: String
}
