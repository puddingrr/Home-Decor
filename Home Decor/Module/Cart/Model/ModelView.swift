//
//  ModelView.swift
//  Home Decor
//
//  Created by Dalynn on 6/1/26.
//
import Foundation

struct AddressItem: Identifiable {
    let id = UUID()
    let fullAddress: String
    let contactName: String
    let phone: String
    let tags: [String]
    let isDefault: Bool
}
