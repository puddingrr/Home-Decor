//
//  CategoryMenuModelView.swift
//  Home Decor
//
//  Created by Dalynn on 12/6/25.
//

import Foundation
import SwiftUI

struct ListMenu: Identifiable, Codable, Hashable {
    let id: String?
    let image: String?
    let title: String?
    let subTitle: String?
    let price: String?
    var quantity: Int?
}
