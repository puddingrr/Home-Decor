//
//  ProductSeeder.swift
//  Home Decor
//
//  Created by Dalynn on 12/8/25
//

import Foundation
import FirebaseFirestore

struct ProductSeeder {

    static func seedMenu() async {

        let db = Firestore.firestore()
        let menuRef = db.collection("menu")

        // 🔹 SOFA PRODUCTS
        let sofaProducts: [[String: Any]] = [
            [
                "name": "Luxe Lounge Sofa",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 420.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBbMz.16245-13x.png"
            ],
            [
                "name": "Stylish Sofa",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 199.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBcI6.16245-13x-1.png"
            ],
            [
                "name": "Contemporary Sofa",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 2990.00,
                "imageURL": "https://png.pngtree.com/png-vector/20250330/ourmid/pngtree-minimalist-beige-sofa-with-wooden-frame-for-modern-living-room-and-png-image_15904995.png"
            ],
            [
                "name": "Chesterfield Sofa",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 230.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjB8JK.16245-13x-3.png"
            ],
            [
                "name": "Velvet Sofa",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 300.00,
                "imageURL": "https://e7.pngegg.com/pngimages/814/492/png-clipart-sofa-bed-chaise-longue-couch-ambiente-modern-furniture-chair-angle-furniture.png"
            ],
            [
                "name": "Pinker Sofa",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 350.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBgxF.16245-13x-2.png"
            ]
        ]

        // 🔹 BED PRODUCTS
        let bedProducts: [[String: Any]] = [
            [
                "name": "Brown Bed",
                "description": "Soft and comfortable",
                "price": 280.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBtSG.16245-13x-8.png"
            ],
            [
                "name": "Green Bed",
                "description": "Minimal design",
                "price": 285.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBErJ.16245-23x.png"
            ],
            [
                "name": "Single Bed",
                "description": "Soft and comfortable",
                "price": 294.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBwIT.16245-13x-7.png"
            ],
            [
                "name": "King Bed",
                "description": "Soft and comfortable",
                "price": 405.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjB9gW.16245-13x-9.png"
            ],
            [
                "name": "Trundle Bed",
                "description": "Soft and comfortable",
                "price": 420.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBhVf.16245-13x-6.png"
            ],
            [
                "name": "Big Bed",
                "description": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeJLPbc5Op-pIjS0PiLgxGoy8MPvD2GnNGzA&s",
                "price": 300.00,
                "imageURL": ""
            ]
        ]
        
        // 🔹 Chair PRODUCTS
        let chairProducts: [[String: Any]] = [
            [
                "name": "Aluminum chair",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 120.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjB7Eq.Group-3103x.png"
            ],
            [
                "name": "Stylish chair",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 120.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBF68.Group-3103x-1.png"
            ],
            [
                "name": "elegance chair",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 126.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBMcz.Rectangle-223x.png"
            ],
            [
                "name": "Furniture Chair",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 405.00,
                "imageURL": "https://images.rawpixel.com/image_png_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvbHIvcC00NjctcG9tLTAzMjUucG5n.png"
            ],
            [
                "name": "Modern Chair",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 420.00,
                "imageURL": "https://png.pngtree.com/png-vector/20240511/ourlarge/pngtree-modern-wood-and-boucle-chare-dining-chair-png-image_12437948.png"
            ],
            [
                "name": "Office Chair",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 220.00,
                "imageURL": "https://img.freepik.com/free-psd/modern-white-office-chair-with-chrome-accents_191095-80595.jpg?semt=ais_hybrid&w=740&q=80"
            ]
        ]
        
        // 🔹 Desk PRODUCTS
        let deskProducts: [[String: Any]] = [
            [
                "name": "Classic Desktop",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 239.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjnL3q.16245-13x-10.png"
            ],
            [
                "name": "Modern Desktop",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 457.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjncWS.16245-13x-12.png"
            ],
            [
                "name": "Minimalist desktop",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 189.00,
                "imageURL": "https://i.im.ge/2026/01/15/Gjnmjr.16245-13x-11.png"
            ],
            [
                "name": "bronze Desktop",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 282.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjnpmM.16245-13x-13.png"
            ],
            [
                "name": "White Desktop",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 520.00,
                "imageURL": "https://i.im.ge/2026/01/15/Gj4Msp.16245-13x-14.png"
            ],
            [
                "name": "Office Chair",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 220.00,
                "imageURL": "https://img.freepik.com/free-psd/modern-home-office-workspace-setup-with-desk-computer-chair_632498-24177.jpg?semt=ais_hybrid&w=740&q=80"
            ]
        ]
        // 🔹 Dining Table PRODUCTS
        let tableProducts: [[String: Any]] = [
            [
                "name": "Deluxe table",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 420.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBZPX.16245-13x-1.png"
            ],
            [
                "name": "Modern Table",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 320.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBKf8.16245-13x-2.png"
            ],
            [
                "name": "Modern Glass Table",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 220.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBk9M.16245-13x-4.png"
            ],
            [
                "name": "Bohemian Table",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 410.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBfuh.16245-13x-3.png"
            ],
            [
                "name": "Blue Table",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 310.00,
                "imageURL": "https://img.freepik.com/free-psd/modern-dining-set-elegant-minimalist-table-chairs_191095-86318.jpg?semt=ais_hybrid&w=740&q=80"
            ],
            [
                "name": "Brown Table",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 550.00,
                "imageURL": "https://img.freepik.com/premium-psd/table-with-chairs-table-with-pot-olives-it_1153121-5341.jpg?semt=ais_hybrid&w=740&q=80"
            ]
        ]
        // 🔹 Auxiliary furniture PRODUCTS
        let auxiliaryProducts: [[String: Any]] = [
            [
                "name": " Kitchen Hutch",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 620.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBvI4.16245-13x-5.png"
            ],
            [
                "name": "Wooden Kitchen",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 680.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBJxC.16245-13x-9.png"
            ],
            [
                "name": "Vintage Cabinet",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 270.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBnnq.16245-13x-6.png"
            ],
            [
                "name": "Marble Shelving ",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 80.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBBdp.16245-13x-7.png"
            ],
            [
                "name": "Kitchen Shelving",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 15.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBGPP.16245-13x-8.png"
            ],
            [
                "name": "Brown Table",
                "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
                "price": 40.00,
                "imageURL": "https://i.im.ge/2026/01/15/GjBek1.alejandrao-httpss-mj-13x.png"
            ]
        ]
        do {
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
            
            try await menuRef.document("auxiliary").setData([
                "title": "Auxiliary",
                "products": auxiliaryProducts
            ])

            print("🎉 Menu seeded successfully")

        } catch {
            print("❌ Menu seeding failed: \(error.localizedDescription)")
        }
    }
}
