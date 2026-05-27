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
                price: 420,
                imageURL: "https://www.magnific.com/free-photos-vectors/blue-sofa-png"
            ),

            product(
                name: "Stylish Sofa",
                description: "Elegant stylish sofa",
                price: 199,
                imageURL: "https://www.nicepng.com/maxp/u2t4o0o0u2o0t4r5/"
            ),

            product(
                name: "Contemporary Sofa",
                description: "Contemporary modern sofa",
                price: 2990,
                imageURL: "https://www.freepik.com/free-photos-vectors/modern-sofa-png"
            )
        ]

        // MARK: - Bed Products
        let bedProducts: [[String: Any]] = [
            product(
                name: "Brown Bed",
                description: "Soft and comfortable",
                price: 280,
                imageURL: "https://fr.pinterest.com/pin/765823111612860378/"
            ),

            product(
                name: "Modern Bed",
                description: "Minimal design",
                price: 285,
                imageURL: "https://www.bedworld.net/"
            ),

            product(
                name: "White Bed",
                description: "Large king-size bed",
                price: 300,
                imageURL: "https://in.pinterest.com/pin/double-bed-mattress-png-and-clipart--815925657472686738/"
            )
        ]

        // MARK: - Chair Products
        let chairProducts: [[String: Any]] = [
            product(
                name: "Aluminum Chair",
                description: "Modern aluminum chair",
                price: 120,
                imageURL: "https://www.eamesoffice.com/product/eames-aluminum-group-management-chair/"
            ),

            product(
                name: "Modern Chair",
                description: "Elegant modern chair",
                price: 220,
                imageURL: "https://leibal.com/furniture/aluminum-chair/"
            ),
            
            product(
                name: "Best Chair",
                description: "Elegant modern chair",
                price: 220,
                imageURL: "https://marc-newson.com/newson-aluminum-chair/"
            )
        ]

        // MARK: - Desk Products
        let deskProducts: [[String: Any]] = [
            product(
                name: "Classic Desk",
                description: "Classic wooden desk",
                price: 239,
                imageURL: "https://www.ubuy.com.kh/en/product/1AUEWM2-techni-mobili-contempo-desk-with-3-storage-drawers-white?srsltid=AfmBOooHsLeu9NMZn-HgOdm-faem9dsjCSBpKFPWZUX9hqu2QLrzDj_4"
            ),

            product(
                name: "Modern Desk",
                description: "Modern office desk",
                price: 457,
                imageURL: "https://fargowoodworks.com/products/the-sienna-desk/"
            ),
            
            product(
                name: "Slim Desk",
                description: "Modern office desk",
                price: 457,
                imageURL: "https://www.ikea.com/us/en/p/micke-desk-black-brown-10244743/"
            )
        ]

        // MARK: - Table Products
        let tableProducts: [[String: Any]] = [
            product(
                name: "Deluxe Table",
                description: "Luxury dining table",
                price: 420,
                imageURL: "https://www.sundays-company.com/products/field-dining-table-american-walnut?srsltid=AfmBOor8IU_lo1nxotzUkZlE9Py9RJYSiWYogm6RlgH3hHLSejsjKLJ0"
            ),

            product(
                name: "Modern Glass Table",
                description: "Glass dining table",
                price: 220,
                imageURL: "https://www.homary.com/item/midcentury-modern-glass-wood-coffee-table-square-chic-walnut-coffee-table-style-b-12452.html"
            ),
            product(
                name: "Office Glass Table",
                description: "Glass dining table",
                price: 220,
                imageURL: "https://www.cantoni.com/product/skorpio-glass-dining-table-118-in?srsltid=AfmBOor_qlG9Fz58IptjAEj0_Vv04kbGWp3totGo3ClOf0tO6vQuKrk5"
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
