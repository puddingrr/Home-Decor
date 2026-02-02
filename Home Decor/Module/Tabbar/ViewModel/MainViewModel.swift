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

enum Tab: Int, Identifiable, CaseIterable, Comparable {
    
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case home, shop, cart, profile
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .home:
            return "house.fill"
        case .shop:
            return "cart.fill"
        case .cart:
            return "truck.box.fill"
        case .profile:
            return "person.fill"
        }
    }
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .shop:
            return "Shop"
        case .cart:
            return "Cart"
        case .profile:
            return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .home: return .main
        case .shop: return .main
        case .cart: return .main
        case .profile: return .main
        }
    }
}
