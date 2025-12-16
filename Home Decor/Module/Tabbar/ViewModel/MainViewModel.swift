//
//  MainViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 8/25/25.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var tabIndex: Int = 0
    @Published var isLoggedIn: Bool = false
    
    let mainTabList: [TabItemModel] = [
        .init(icon: .homeIcon, activeIcon: .homeActive),
        .init(icon: .menuIcon, activeIcon: .menuActive),
        .init(icon: .cartIcon, activeIcon: .cartActive),
        .init(icon: .wishlistIcon, activeIcon: .wishlistActive),
        .init(icon: .profileIcon, activeIcon: .profileActive)
    ]
    func checkLogin() {
        isLoggedIn = UserPreference.shared.getLoginData() != nil
    }
}
