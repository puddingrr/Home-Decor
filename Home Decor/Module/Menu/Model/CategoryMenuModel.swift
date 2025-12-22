//
//  CategoryMenuModelView.swift
//  Home Decor
//
//  Created by Dalynn on 12/6/25.
//

import Foundation
import SwiftUI

struct ListMenu: Identifiable {
    let id = UUID()
    let image: ImageResource
    let title: String
    let subTitle: String
    let price: String
}
