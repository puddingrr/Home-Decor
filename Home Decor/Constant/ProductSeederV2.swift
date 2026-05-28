//
//  FeaturedSeeder.swift
//  Home Decor
//

import Foundation
import FirebaseFirestore

struct FeaturedSeeder {

    static func seedFeaturedProducts() async {

        let db = Firestore.firestore()
        let featuredRef = db.collection("featuredProducts")

        // MARK: - Product Helper
        func product(
            id: String = UUID().uuidString,
            name: String,
            description: String,
            price: Double,
            imageURL: String,
            category: String
        ) -> [String: Any] {

            return [
                "id": id,
                "name": name,
                "description": description,
                "price": price,
                "imageURL": imageURL,
                "category": category,
                "createdAt": Timestamp()
            ]
        }

        // MARK: - Featured Products
        let featuredProducts: [[String: Any]] = [
            product(
                name: "Luxury Velvet Sofa",
                description: "Premium modern velvet sofa",
                price: 1700,
                imageURL: "https://i.pinimg.com/1200x/66/50/18/6650184cbbf1d130cba50b98b6a136b5.jpg",
                category: "Sofa"
            ),

            product(
                name: "Minimal Wooden Desk",
                description: "Elegant workspace desk",
                price: 780,
                imageURL: "https://i.pinimg.com/736x/b9/c3/82/b9c3829f4f44ec57dbb7a2dd58612bf4.jpg",
                category: "Desk"
            ),

            product(
                name: "Comfort Gaming Chair",
                description: "Ergonomic gaming chair",
                price: 320,
                imageURL: "https://i.pinimg.com/1200x/60/e7/7f/60e77fc680c9eee600faade5dd1a1e06.jpg",
                category: "Chair"
            ),
            product(
                name: "Velvet Bed",
                description: "Premium modern velvet bed",
                price: 1200,
                imageURL: "https://i.pinimg.com/1200x/3f/5f/56/3f5f560c74d561b15f0ba7bfe2c66a03.jpg",
                category: "Bed"
            ),

            product(
                name: "Wooden Desk",
                description: "Elegant workspace desk",
                price: 1100,
                imageURL: "https://i.pinimg.com/1200x/ae/8a/52/ae8a5232ad69084ef0dd6f7eafdab087.jpg",
                category: "Desk"
            ),

            product(
                name: "Cozy Chair",
                description: "Ergonomic gaming chair",
                price: 320,
                imageURL: "https://i.pinimg.com/736x/17/8b/db/178bdb31a43ede449a1c305d0266e2f7.jpg",
                category: "Chair"
            )
        ]

        do {

            for item in featuredProducts {

                let id = item["id"] as? String ?? UUID().uuidString

                try await featuredRef
                    .document(id)
                    .setData(item)
            }

            print("✅ Featured products seeded successfully")

        } catch {
            print("❌ Featured seeding failed: \\(error.localizedDescription)")
        }
    }
}
