//
//  HomeModel.swift
//  Home Decor
//
//  Created by Dalynn on 8/26/25.
//
import Foundation
import SwiftUI

struct categoryList {
    let icon, activeIcon: ImageResource
}

struct ProductModel: Identifiable {
    let id: String?
    let name: String?
    let description: String?
    let price: Double?
    let imageURL: String?
    let category: String?
}
