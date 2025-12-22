//
//  CategoryViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 12/6/25.
//

import Foundation
import SwiftUI

class CategoryViewModel: ObservableObject {
    @Published var indexTab: Int? = 0
    @Published var selectID: Int? = 0
    @Published var selectTitle: String = ""
    @Published var isNavigated: Bool = false
    @Published var navType: MenuNavigationType = .none

    func navigate(_ type: MenuNavigationType) {
        navType = type
        isNavigated = true
    }
    
    var list: [ListMenu] = [
        .init(image: .chair1, title: "Aluminum chair", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", price: "120.00"),
        .init(image: .chair2, title: "Stylish chair", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", price: "120.00"),
        .init(image: .chair1, title: "Aluminum chair", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", price: "120.00"),
        .init(image: .chair2, title: "Stylish chair", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", price: "120.00"),
        .init(image: .chair1, title: "Aluminum chair", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", price: "120.00"),
        .init(image: .chair2, title: "Stylish chair", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", price: "120.00")
    ]
    let itemsTab = ["Beds", "Chairs", "Tables" , "Sofa", "Cupboard", "Desk", "Auxiliary furniture", "Dining Table"]
}

enum MenuNavigationType {
    case search
    case menuList(id: Int, title: String)
    case none
}
