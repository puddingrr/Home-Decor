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
        let profileIcon = db.collection("products")
//        _ = db.collection("bed")
//        let auxiliaryfurniture = db.collection("auxiliaryfurniture")
        
        let sampleProduct: [[String: Any]] = [
            [
                "name": "Profile Image",
                "category": "profile",
                "imageURLs": [
                    "https://i.pinimg.com/736x/be/97/ba/be97ba4998b0edb6809adb9558ba5902.jpg",
                    "https://i.pinimg.com/736x/7d/0d/74/7d0d74b39c5e9ded82237d10859cf717.jpg",
                    "https://i.pinimg.com/736x/7a/ed/5a/7aed5aacabbd7d8ba9b986ca8a6789e4.jpg",
                    "https://i.pinimg.com/736x/c4/f7/c9/c4f7c969ccc5bca8c906ff00469bd926.jpg",
                    "https://i.pinimg.com/736x/6e/11/40/6e11404fcea7606ce86bc74c1dd01fe7.jpg",
                    "https://i.pinimg.com/736x/fe/1e/c6/fe1ec6171aee30852eaa4c4dbe3795c4.jpg",
                    "https://i.pinimg.com/736x/0d/40/89/0d408927a45135807514cef6bbe79f7f.jpg",
                    "https://i.pinimg.com/474x/d3/c8/f8/d3c8f80bfd0720e3e9edc84ea93c6770.jpg",
                    "https://i.pinimg.com/736x/12/94/24/129424347984aaee0fcf9724128dfd73.jpg",
                    "https://i.pinimg.com/736x/07/26/09/072609b016bb99240a1ca30b52a80725.jpg"
                ]
            ]
        ]

        for profile in sampleProduct {
            do {
                _ = try await profileIcon.addDocument(data: profile)
                print("✅ Added product: \(profile["name"] ?? "")")
            } catch {
                print("❌ Failed to add product: \(error.localizedDescription)")
            }
        }
    }
}
//let sampleSofa: [[String: Any]] = [ //sofa
//    [
//        "name": "Luxe Lounge Sofa",
//        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
//        "price": 420.00,
//        "category": "Sofa",
//        "imageURL": "https://www.hiclipart.com/search?clipart=modern+Sofa"
//    ],
//    [
//        "name": "Contemporary Sofa",
//        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
//        "price": 320.00,
//        "category": "Sofa",
//        "imageURL": "https://www.hiclipart.com/search?clipart=modern+Sofa"
//    ],
//    [
//        "name": "Chesterfield Sofa",
//        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
//        "price": 420.00,
//        "category": "Sofa",
//        "imageURL": "https://www.hiclipart.com/search?clipart=modern+Sofa"
//    ],
//    [
//        "name": "Scandinavian Sofa",
//        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
//        "price": 420.00,
//        "category": "Sofa",
//        "imageURL": "https://www.hiclipart.com/search?clipart=modern+Sofa"
//    ],
//    [
//        "name": "Velvet Sofa",
//        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
//        "price": 420.00,
//        "category": "Sofa",
//        "imageURL": "https://www.hiclipart.com/search?clipart=modern+Sofa"
//    ],
//    [
//        "name": "Stylish Sofa",
//        "description": "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
//        "price": 420.00,
//        "category": "Sofa",
//        "imageURL": "https://www.hiclipart.com/search?clipart=modern+Sofa"
//    ],
//]
