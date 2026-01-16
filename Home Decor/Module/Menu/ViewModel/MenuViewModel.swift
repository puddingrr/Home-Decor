//
//  CategoryViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 12/6/25.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class MenuViewModel: ObservableObject {
    
    @Published var menuList: [ListMenu] = []
    
    @Published var indexTab: Int? = 0
    @Published var selectID: Int? = 0
    @Published var selectTitle: String = ""
    @Published var isNavigated: Bool = false
    @Published var navType: MenuNavigationType = .none

    func navigate(_ type: MenuNavigationType) {
        navType = type
        isNavigated = true
    }

    let itemsTab = ["Beds", "Chairs" , "Sofa", "Desk", "Auxiliary furniture", "Dining Table"]
    
    private let db = Firestore.firestore()
    
    func fetchCategory(_ category: String) async {
        do {
            let doc = try await db.collection("menu").document(category).getDocument()
            if let data = doc.data(),
               let products = data["products"] as? [[String: Any]] {
                
                DispatchQueue.main.async {
                    self.menuList = products.map { item in
                        ListMenu(
                            id: UUID(),
                            image: item["imageURL"] as? String ?? "",
                            title: item["name"] as? String ?? "",
                            subTitle: item["description"] as? String ?? "",
                            price: String(format: "%.2f", item["price"] as? Double ?? 0)
                        )
                    }
                }
            }
        } catch {
            print("❌ Failed to fetch category \(category): \(error.localizedDescription)")
        }
    }
}

enum MenuNavigationType {
    case search
    case menuList(category: String, title: String)
    case none
}

enum MenuCategory: String {
    case sofa
    case chair
    case bed
    case desk
    case table
    case auxiliary
}
