//
//  CartViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 12/15/25.
//

import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cartItems: [ListMenu] = []

    @discardableResult
    func addToCart(_ item: ListMenu) -> Bool {
        if cartItems.contains(where: { $0.id == item.id }) {
            return false
        }
        var newItem = item
        newItem.quantity = 1
        cartItems.append(newItem)
        return true
    }

    func updateItem(_ item: ListMenu) {
        guard let index = cartItems.firstIndex(where: { $0.id == item.id }) else { return }
        cartItems[index] = item
    }

    func removeFromCart(_ item: ListMenu) {
        cartItems.removeAll { $0.id == item.id }
    }

    func clearCart() {
        cartItems.removeAll()
    }
}
