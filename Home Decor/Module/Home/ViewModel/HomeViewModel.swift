//
//  HomeViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 8/26/25.
//

import Foundation

class HomeViewModel : ObservableObject {
    @Published var selectedIndex: Int = 0
    let animeList: [String] = ["animeList" , "animeList" , "animeList" ]
    
    let list: [categoryList] = [
        .init(icon: .sofa, activeIcon: .sofaActive),
        .init(icon: .bed, activeIcon: .bedActive),
        .init(icon: .tabble, activeIcon: .tableActive),
        .init(icon: .kitchen, activeIcon: .kitchenActive),
        .init(icon: .chair, activeIcon: .chairActive)
    ]
    
    let collectList: [collectionList] = [
        .init(image: .chair1, title: "Aluminum chair", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", price: "120.00"),
        .init(image: .chair2, title: "Stylish chair", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", price: "120.00")
    ]
}
