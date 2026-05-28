//
//  ProductSeeder.swift
//  Home Decor
//

import Foundation
import FirebaseFirestore

struct ProductSeeder {

    static func seedMenu() async {

        let db = Firestore.firestore()
        let menuRef = db.collection("menu")

        // MARK: - Helper
        func product(
            id: String = UUID().uuidString,
            name: String,
            description: String,
            price: Double,
            imageURL: String
        ) -> [String: Any] {

            return [
                "id": id,
                "name": name,
                "description": description,
                "price": price,
                "imageURL": imageURL
            ]
        }

        // MARK: - Sofa Products
        let sofaProducts: [[String: Any]] = [
            product(
                name: "Luxe Lounge Sofa",
                description: "Modern luxury sofa",
                price: 1600,
                imageURL: "https://i.pinimg.com/736x/32/47/9c/32479c2e68e2dcbc7d614a3fd14df46b.jpg"
            ),

            product(
                name: "Stylish Sofa",
                description: "Elegant stylish sofa",
                price: 1400,
                imageURL: "https://i.pinimg.com/1200x/c6/88/3b/c6883b6440d54aa57ed2f48f83d57a4c.jpg"
            ),

            product(
                name: "Contemporary Sofa",
                description: "Contemporary modern sofa",
                price: 2990,
                imageURL: "https://i.pinimg.com/736x/8e/47/49/8e47492d8c58853ab751616300ce2a6f.jpg"
            ),
            product(
                name: "Big Sofa",
                description: "Modern luxury sofa",
                price: 1999,
                imageURL: "https://i.pinimg.com/736x/32/47/9c/32479c2e68e2dcbc7d614a3fd14df46b.jpg"
            ),

            product(
                name: "Fresh Sofa",
                description: "Elegant stylish sofa",
                price: 1532,
                imageURL: "https://i.pinimg.com/736x/3c/db/72/3cdb72f9f17c8aa127770db1984ef686.jpg"
            ),
            product(
                name: "Small Sofa",
                description: "Contemporary modern sofa",
                price: 1000,
                imageURL: "https://i.pinimg.com/1200x/10/82/26/1082266b84101dba7d15808a7d6ad356.jpg"
            )
        ]

        // MARK: - Bed Products
        let bedProducts: [[String: Any]] = [
            product(
                name: "Brown Bed",
                description: "Soft and comfortable",
                price: 900,
                imageURL: "https://i.pinimg.com/736x/54/44/88/544488e9ca207b1dae663ec78f1cdc43.jpg"
            ),

            product(
                name: "Modern Bed",
                description: "Minimal design",
                price: 1200,
                imageURL: "https://i.pinimg.com/736x/f1/09/c8/f109c8e551ec8078e9a27060b268f45d.jpg"
            ),
            product(
                name: "White Bed",
                description: "Large king-size bed",
                price: 2310,
                imageURL: "https://i.pinimg.com/1200x/41/f1/dd/41f1ddae6dc09a0639175053ceb19d3d.jpg"
            ),
            product(
                name: "Green Bed",
                description: "Soft and comfortable",
                price: 1390,
                imageURL: "https://i.pinimg.com/1200x/17/b2/09/17b209e9565b8007de703ccdf0a26dbe.jpg"
            ),

            product(
                name: "Sea Bed",
                description: "Minimal design",
                price: 2700,
                imageURL: "https://i.pinimg.com/736x/e2/3c/c4/e23cc465bbbdd1e590af8aae562a37bc.jpg"
            ),

            product(
                name: "Soft Bed",
                description: "Large king-size bed",
                price: 1980,
                imageURL: "https://i.pinimg.com/736x/35/95/99/359599f8ad594529c5084629c58a0f72.jpg"
            )
        ]

        // MARK: - Chair Products
        let chairProducts: [[String: Any]] = [
            product(
                name: "Aluminum Chair",
                description: "Modern aluminum chair",
                price: 120,
                imageURL: "https://i.pinimg.com/1200x/bc/e2/97/bce297a08b9d162fb4ddc3098239c928.jpg"
            ),

            product(
                name: "Gamming Chair",
                description: "Elegant modern chair",
                price: 220,
                imageURL: "https://i.pinimg.com/736x/64/61/eb/6461eb76f3341c37618c753c3001749f.jpg"
            ),
            
            product(
                name: "Modern Chair",
                description: "Elegant modern chair",
                price: 220,
                imageURL: "https://i.pinimg.com/736x/1c/b6/bf/1cb6bfc2b3142fa94e47563d170f8db7.jpg"
            ),
            product(
                name: "Office Chair",
                description: "Modern aluminum chair",
                price: 120,
                imageURL: "https://i.pinimg.com/1200x/cf/a0/4b/cfa04b231093dff81d2cfd4cf2233460.jpg"
            ),

            product(
                name: "Pink Chair",
                description: "Elegant modern chair",
                price: 220,
                imageURL: "https://i.pinimg.com/1200x/08/b4/59/08b459bbebea3326614dbd22aaddfe08.jpg"
            ),
            
            product(
                name: "Cute Chair",
                description: "Elegant modern chair",
                price: 220,
                imageURL: "https://i.pinimg.com/1200x/14/63/4f/14634f9a0206c91405b406c5b846b1c4.jpg"
            )
        ]

        // MARK: - Desk Products
        let deskProducts: [[String: Any]] = [
            product(
                name: "Classic Desk",
                description: "Classic wooden desk",
                price: 390,
                imageURL: "https://i.pinimg.com/736x/dc/a9/e3/dca9e30a1354f16ea6c7d7485c84ea49.jpg"
            ),

            product(
                name: "Modern Desk",
                description: "Modern office desk",
                price: 680,
                imageURL: "https://i.pinimg.com/736x/c4/a6/c9/c4a6c9ff4f2e48324c02f96d44a0144b.jpg"
            ),
            
            product(
                name: "Slim Desk",
                description: "Home decore desk",
                price: 230,
                imageURL: "https://i.pinimg.com/736x/61/b0/ba/61b0ba5ddd3f61c80fcc1839f93af245.jpg"
            ),
            product(
                name: "Office Desk",
                description: "Classic wooden desk",
                price: 420,
                imageURL: "https://i.pinimg.com/736x/23/8c/8b/238c8b5bb4357df9cd7069017e1d7599.jpg"
            ),

            product(
                name: "Pink Desk",
                description: "Modern office desk",
                price: 500,
                imageURL: "https://i.pinimg.com/1200x/aa/fc/96/aafc9697708453064b08e73f134bdfe0.jpg"
            ),
            
            product(
                name: "Design Desk",
                description: "Modern office desk",
                price: 400,
                imageURL: "https://i.pinimg.com/736x/5f/9a/22/5f9a22bcbe128317cd1adf773faf2bbb.jpg"
            )
        ]

        // MARK: - Table Products
        let tableProducts: [[String: Any]] = [
            product(
                name: "Deluxe Table",
                description: "Luxury dining table",
                price: 420,
                imageURL: "https://i.pinimg.com/1200x/40/2c/81/402c810bf368d66c16e3d255be9d892e.jpg"
            ),

            product(
                name: "Modern Glass Table",
                description: "Glass dining table",
                price: 220,
                imageURL: "https://i.pinimg.com/1200x/57/65/31/576531bf1aa9926d9e094d7af1c6b58a.jpg"
            ),
            product(
                name: "Office Glass Table",
                description: "Glass dining table",
                price: 220,
                imageURL: "https://i.pinimg.com/1200x/e7/17/a1/e717a186117205407ad70071f069e4de.jpg"
            ),
            product(
                name: "White Table",
                description: "Luxury dining table",
                price: 420,
                imageURL: "https://i.pinimg.com/1200x/9d/39/21/9d3921e8c29fc3d9d7db2d8aa46edfc8.jpg"
            ),
            product(
                name: "Circle Table",
                description: "Dining table free 4 chairs",
                price: 220,
                imageURL: "https://i.pinimg.com/1200x/07/20/0d/07200db069d813d37e70dadfeaa88188.jpg"
            ),
            product(
                name: "Bar Table",
                description: "Dining table free 3 chairs",
                price: 220,
                imageURL: "https://i.pinimg.com/736x/26/44/9a/26449a8fa46016dbb5cafc558295a968.jpg"
            )
        ]

        do {

            try await menuRef.document("sofa").setData([
                "title": "Sofa",
                "products": sofaProducts
            ])

            try await menuRef.document("bed").setData([
                "title": "Bed",
                "products": bedProducts
            ])

            try await menuRef.document("chair").setData([
                "title": "Chair",
                "products": chairProducts
            ])

            try await menuRef.document("desk").setData([
                "title": "Desk",
                "products": deskProducts
            ])

            try await menuRef.document("table").setData([
                "title": "Table",
                "products": tableProducts
            ])

            print("✅ Menu seeded successfully")

        } catch {
            print("❌ Menu seeding failed: \(error.localizedDescription)")
        }
    }
}
