//
//  HomeViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 8/26/25.
//

import Foundation
import FirebaseFirestore

class HomeViewModel : ObservableObject {
    @Published var featuredProducts: [ProductModel] = []
    private let db = Firestore.firestore()
    
    @Published var indexTab: Int? = 0
    @Published var selectedIndex: Int = 0
    @Published var pageIndex: Int = 0
    
    @Published var isHomeNavigation: Bool = false
    @Published var navType: HomeNavigationType = .none

    @Published var search: Bool = false
    @Published var isNavLogin: Bool = false
    @Published var isNavRegister: Bool = false
    @Published var isLoggedIn: Bool = false

    let animeList: [String] = ["animeList" , "banner1" , "banner2" ]
    
    let itemsTab = ["Explore", "Shop", "Carts", "Orders"]
    
    let list: [categoryList] = [
        .init(icon: .sofa, activeIcon: .sofaActive),
        .init(icon: .bed, activeIcon: .bedActive),
        .init(icon: .tabble, activeIcon: .tableActive),
        .init(icon: .kitchen, activeIcon: .kitchenActive),
        .init(icon: .chair, activeIcon: .chairActive)
    ]
    
//    let collectList: [ListMenu] = [
//        .init(image: .chair1, title: "Aluminum chair", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", price: "120.00"),
//        .init(image: .chair2, title: "Stylish chair", subTitle: "Lorem ipsum dolor sit amet, consectetur adipiscing elit", price: "120.00")
//    ]

    func fetchFeaturedProducts() {
        db.collection("featuredProducts")
            .getDocuments { snapshot, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let snapshot = snapshot else { return }
                let products = snapshot.documents.compactMap { doc -> ProductModel? in
                    let data = doc.data()
                    return ProductModel(
                        id: doc.documentID,
                        name: data["name"] as? String ?? "",
                        description: data["description"] as? String ?? "",
                        price: data["price"] as? Double ?? 0,
                        imageURL: data["imageURL"] as? String ?? "",
                        category: data["category"] as? String ?? ""
                    )
                }
                let allSafeData = snapshot.documents.map { doc -> [String: Any] in
                    doc.data().mapValues { value -> Any in
                        switch value {
                        case let ts as Timestamp: return ts.dateValue().description
                        case let ref as DocumentReference: return ref.path
                        default: return value
                        }
                    }
                }
                if let jsonData = try? JSONSerialization.data(withJSONObject: allSafeData, options: .prettyPrinted),
                   let jsonStr = String(data: jsonData, encoding: .utf8) {
                    FirebaseLog.shared.logResponse(url: "firestore://featuredProducts", responseBody: jsonStr)
                }
                DispatchQueue.main.async {
                    self.featuredProducts = products
                }
            }
    }
}
enum HomeNavigationType {
    case serach
    case login
    case register
    case detailProduct
    case none
}
