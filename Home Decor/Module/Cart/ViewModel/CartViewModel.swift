//
//  CartViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 1/16/26.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cartItems: [ListMenu] = []

    private let db = Firestore.firestore()
    private var userID: String? {
        Auth.auth().currentUser?.uid
    }
    
    init() {
        fetchCart()
    }

    @MainActor
        func addToCart(_ item: ListMenu) async -> Bool {
            guard let uid = userID else { return false }

            // Prevent duplicates
            if cartItems.contains(where: { $0.id == item.id }) {
                return false
            }

            cartItems.append(item)
            FirebaseLog.shared.logFirebase(.fetch, collection: "carts/\(uid)", extra: "Adding: \(item.id ?? "")")

            do {
                try await db.collection("carts")
                    .document(uid)
                    .setData(["items": cartItems.map { try! DictionaryEncoder.encode($0) }])
                return true
            } catch {
                print("❌ Failed to add item: \(error.localizedDescription)")
                return false
            }
        }

    func fetchCart() {
          guard let uid = userID else { return }
          FirebaseLog.shared.logFirebase(.fetch, collection: "carts/\(uid)")
          db.collection("carts").document(uid).addSnapshotListener { [weak self] snapshot, error in
              guard let self = self else { return }
              if let data = snapshot?.data(),
                 let itemsData = data["items"] as? [[String: Any]] {
                  self.cartItems = itemsData.compactMap { dict in
                      try? DictionaryDecoder.decode(ListMenu.self, from: dict)
                  }
                  if let jsonData = try? JSONSerialization.data(withJSONObject: itemsData, options: .prettyPrinted),
                     let jsonStr = String(data: jsonData, encoding: .utf8) {
                      FirebaseLog.shared.logResponse(url: "firestore://carts/\(uid)", responseBody: jsonStr)
                  }
              } else {
                  self.cartItems = []
              }
          }
      }

    func clearCart() async {
        guard let uid = userID else { return }
        cartItems.removeAll()
        do {
            try await db.collection("carts").document(uid).setData(["items": []])
            FirebaseLog.shared.logFirebase(.fetch, collection: "carts/\(uid)", extra: "Clearing cart")
        } catch {
            print("❌ Failed to clear cart: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func updateItem(_ item: ListMenu) async {
        guard let uid = userID else { return }
        if let index = cartItems.firstIndex(where: { $0.id == item.id }) {
            cartItems[index] = item
        }
        do {
            try await db.collection("carts")
                .document(uid)
                .setData(["items": cartItems.map { try! DictionaryEncoder.encode($0) }])
        } catch {
            print("❌ Failed to update item: \(error.localizedDescription)")
        }
    }

    @MainActor
    func removeFromCart(_ item: ListMenu) async {
        guard let uid = userID else { return }
        cartItems.removeAll { $0.id == item.id }
        do {
            try await db.collection("carts")
                .document(uid)
                .setData(["items": cartItems.map { try! DictionaryEncoder.encode($0) }])
        } catch {
            print("❌ Failed to remove item: \(error.localizedDescription)")
        }
    }

}

