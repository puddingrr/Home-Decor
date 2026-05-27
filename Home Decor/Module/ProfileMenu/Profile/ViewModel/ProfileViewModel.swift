//
//  ProfileViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 8/29/25.
//
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var currentUser: LoginDataModel?
    
    @Published var inputText = ""
    @Published var isSelected: Int? = nil
    @Published var isSelectedEdit: Bool = false
    @Published var isOrder: Bool = false
    
    @Published var showGalarryPicker = false
    @Published var showCameraPicker = false
    @Published var selectedFileURLs: [URL] = []
    @Published var isProfileUploaded: Bool = false
    @Published var localProfileImage: UIImage?
    @Published var showPortraitSheet: Bool = false
    @Published var profileImageUrl: String?
    
    private let storageRef = Storage.storage().reference()
    
    init() {
        loadUser()
    }
    
    func loadUser() {
        currentUser = UserPreference.shared.getLoginData()
    }
    func refreshUser(_ user: LoginDataModel) {
        currentUser = user
    }
    
    @objc private func onProfileUpdated() {
        loadUser()
    }
    
    func logout(completion: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        
        UserPreference.shared.clearLoginData()
        completion()
    }
    
    let listTextField: [TextfieldList] = [
        .init(title: "Full name", subTittle: "Madison Smith"),
        .init(title: "Email", subTittle: "madisons@example.com"),
        .init(title: "Mobile Number", subTittle: "+123 4567 890"),
        .init(title: "Date of birth", subTittle: "01 / 04 / 199X")
    ]
    
    let listOrder: [orderList] = [
        .init(status: "Delivered", date: "May 15", image: .nightStand, title: "Serenity Nightstand", subTitle: "In a laoreet purus. Integer turpis quam, laoreet id orci nec, ultrices...", price: "7.50", item: "1", totalPrice: "7.50"),
        .init(status: "Canceled", date: "May 22", image: .lamp, title: "Blue Table Lamp", subTitle: "In a laoreet purus. Integer turpis quam, laoreet id orci nec, ultrices...", price: "25", item: "2", totalPrice: "50"),
        .init(status: "Delivered", date: "June 04", image: .dresser, title: "Bedroom Dresser", subTitle: "In a laoreet purus. Integer turpis quam, laoreet id orci nec, ultrices...", price: "285", item: "1", totalPrice: "285"),
        .init(status: "Delivered", date: "June 12", image: .bedGreen, title: "green Bed", subTitle: "In a laoreet purus. Integer turpis quam, laoreet id orci nec, ultrices...", price: "285", item: "2", totalPrice: "285"),
        .init(status: "Delivered", date: "June 12", image: .bedGreen, title: "green Bed", subTitle: "In a laoreet purus. Integer turpis quam, laoreet id orci nec, ultrices...", price: "285", item: "2", totalPrice: "285")
    ]
    
    let profileInfoList: [ItemModel] = [
        .init(image: "lock.shield", title: "Privacy Policy"),
        .init(image: "creditcard", title: "Payment Methods"),
        .init(image: "bell", title: "Notification"),
        .init(image: "gearshape", title: "Language"),
        .init(image: "questionmark.circle", title: "Help")
    ]

    let otherList: [ItemModel] = [
        .init(image: "sun.max", title: "Appearance"),
        .init(image: "rectangle.portrait.and.arrow.right", title: "Logout")
    ]
}

enum ButtonNavigationType: String {
    case appearance = "Appearance"
    
    
    func destinationView() -> some View {
        switch self {
        case .appearance:
            return AppearanceView()
        }
    }
}


