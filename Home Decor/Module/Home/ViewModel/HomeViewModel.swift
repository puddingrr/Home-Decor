//
//  HomeViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 8/26/25.
//

import Foundation

class HomeViewModel : ObservableObject {
    @Published var selectedIndex: Int = 0
    @Published var pageIndex: Int = 0
    
    @Published var isHomeNavigation: Bool = false
    @Published var navType: HomeNavigationType = .none

    @Published var search: Bool = false
    @Published var isNavLogin: Bool = false
    @Published var isNavRegister: Bool = false
    @Published var isLoggedIn: Bool = false

    let animeList: [String] = ["animeList" , "banner1" , "banner2" ]
    
    let list: [categoryList] = [
        .init(icon: .sofa, activeIcon: .sofaActive),
        .init(icon: .bed, activeIcon: .bedActive),
        .init(icon: .tabble, activeIcon: .tableActive),
        .init(icon: .kitchen, activeIcon: .kitchenActive),
        .init(icon: .chair, activeIcon: .chairActive)
    ]
    
    let collectList: [ListMenu] = [
        .init(image: .chair1, title: "Aluminum chair", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", price: "120.00"),
        .init(image: .chair2, title: "Stylish chair", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", price: "120.00")
    ]
}
enum HomeNavigationType {
    case serach
    case login
    case register
    case detailProduct
    case none
}
