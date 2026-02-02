
//
//  Untitled.swift
//  Home Decor
//
//  Created by Dalynn on 8/29/25.
//
import SwiftUI

struct orderList {
    let status, date: String
    let image: ImageResource
    let title, subTitle: String
    let price, item, totalPrice: String
}

struct ProfileIconModel: Identifiable {
    let id: String
    let imageURLs: [String]
}

