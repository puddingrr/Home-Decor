//
//  ProductSeeder.swift
//  Home Decor
//
//  Created by Dalynn on 12/8/25.
//
import Foundation
import FirebaseFirestore

struct ProductSeeder {
    static func seedSampleProducts() async {
        let db = Firestore.firestore()
        let sofa = db.collection("sofa")
//        _ = db.collection("bed")
//        let auxiliaryfurniture = db.collection("auxiliaryfurniture")

        let sampleSofa: [[String: Any]] = [ //sofa
            [
                "name": "Luxe Lounge Sofa",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 420.00,
                "category": "Sofa",
                "imageURL": "https://www.hiclipart.com/search?clipart=modern+Sofa"
            ],
            [
                "name": "Contemporary Sofa",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 320.00,
                "category": "Sofa",
                "imageURL": "https://www.hiclipart.com/search?clipart=modern+Sofa"
            ],
            [
                "name": "Chesterfield Sofa",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 420.00,
                "category": "Sofa",
                "imageURL": "https://www.hiclipart.com/search?clipart=modern+Sofa"
            ],
            [
                "name": "Scandinavian Sofa",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 420.00,
                "category": "Sofa",
                "imageURL": "https://www.hiclipart.com/search?clipart=modern+Sofa"
            ],
            [
                "name": "Velvet Sofa",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 420.00,
                "category": "Sofa",
                "imageURL": "https://www.hiclipart.com/search?clipart=modern+Sofa"
            ],
            [
                "name": "Stylish Sofa",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 420.00,
                "category": "Sofa",
                "imageURL": "https://www.hiclipart.com/search?clipart=modern+Sofa"
            ],
        ]

        for sofaProduct in sampleSofa {
            do {
                _ = try await sofa.addDocument(data: sofaProduct)
                print("✅ Added product: \(sofaProduct["name"] ?? "")")
            } catch {
                print("❌ Failed to add product: \(error.localizedDescription)")
            }
        }
    }
}
