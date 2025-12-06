//
//  MenuListView.swift
//  Home Decor
//
//  Created by Dalynn on 12/6/25.
//

import SwiftUI

struct MenuListView: View {
    @StateObject var categoryVM = CategoryViewModel()
    @State var isTabIndex: Bool = false
    var body: some View {
        VStack {
            HStack {
                TabView(selection: $categoryVM.indexTab) {
                    CategoryTabView(categoryVM: categoryVM, title: "Decorative Light")
                }
            }
        }
    }
}

enum ListItem: String {
    case decorativeLight = "Decorative Light"
    case beds = "Beds"
    case chairs = "Chairs"
    case sofa = "Sofa"
    case tables = "Tables"
    case cupboard = "Cupboard"
    case livingRoom = "Living Room"
    case auxiliaryFurniture = "Auxiliary furniture"
    case diningTable = "Dining Table"
    case desk = "Desk"
}
