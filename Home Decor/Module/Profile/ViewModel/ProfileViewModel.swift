//
//  ProfileViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 8/29/25.
//
import FirebaseAuth
import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    let listTextField: [TextfieldList] = [
        .init(title: "Full name", subTittle: "Madison Smith"),
        .init(title: "Email", subTittle: "madisons@example.com"),
        .init(title: "Mobile Number", subTittle: "+123 4567 890"),
        .init(title: "Date of birth", subTittle: "01 / 04 / 199X")
    ]
    @Published var inputText = ""
    @Published var isSelected: Int? = nil
    @Published var isSelectedEdit: Bool = false
    @Published var isOrder: Bool = false
    
    let listOrder: [orderList] = [
        .init(status: "Delivered", date: "May 15", image: .nightStand, title: "Serenity Nightstand", subTitle: "In a laoreet purus. Integer turpis quam, laoreet id orci nec, ultrices...", price: "7.50", item: "1", totalPrice: "7.50"),
        .init(status: "Canceled", date: "May 22", image: .lamp, title: "Blue Table Lamp", subTitle: "In a laoreet purus. Integer turpis quam, laoreet id orci nec, ultrices...", price: "25", item: "2", totalPrice: "50"),
        .init(status: "Delivered", date: "June 04", image: .dresser, title: "Bedroom Dresser", subTitle: "In a laoreet purus. Integer turpis quam, laoreet id orci nec, ultrices...", price: "285", item: "1", totalPrice: "285"),
        .init(status: "Delivered", date: "June 12", image: .bedGreen, title: "green Bed", subTitle: "In a laoreet purus. Integer turpis quam, laoreet id orci nec, ultrices...", price: "285", item: "2", totalPrice: "285"),
        .init(status: "Delivered", date: "June 12", image: .bedGreen, title: "green Bed", subTitle: "In a laoreet purus. Integer turpis quam, laoreet id orci nec, ultrices...", price: "285", item: "2", totalPrice: "285")
    ]
    
    let profileInfoList: [ItemModel] = [
        .init(image: .keyPrivacy, title: "Privacy Policy"),
        .init(image: .payment, title: "Payment Methods"),
        .init(image: .notification, title: "Notification"),
        .init(image: .setting, title: "Setting"),
        .init(image: .help, title: "Help"),
    ]
    let otherList: [ItemModel] = [
        .init(image: .logout, title: "Logout")
    ]
    
    func logout(completion: @escaping () -> Void) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }

        // Clear saved user data
        UserPreference.shared.clearLoginData()
        completion()
    }
}

//enum ButtonNavigationType: String {
//    
//    @ViewBuilder
//    func destinationView(completion: @escaping () -> String) -> some View {
//        switch self {
//            
//        }
//    }
//}
