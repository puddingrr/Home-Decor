//
//  BedRoom.swift
//  Home Decor
//
//  Created by Dalynn on 10/22/25.
//

import SwiftUI

struct CategoryMenuView: View {
    @State var search: Bool = false
    @State var viewMenuList: Bool = false
    var body: some View {
        VStack {
            CustomNavBar(title: "Bedroom", trailingBtnIcon: .search, isBack: false, actionTrailingIcon: {
                search.toggle()
            })
            VStack {
                VStack {
                    HStack {
                        VStack {
                            menuCustom(title: "Decorative Light", high: 100, action: {
                                viewMenuList = true
                            })
                            menuCustom(title: "Beds", high: 200)
                            menuCustom(title: "Chairs", high: 130)
                        }
                        VStack {
                            menuCustom(title: "Sofa", high: 130)
                            menuCustom(title: "Tables", high: 130)
                            menuCustom(title: "Cupboard", high: 170)
                        }
                    }
                    menuCustom(title: "Decor", high: 120)
                }
            }
            .padding(16)
        }
        .navigationDestination(isPresented: $search) {
            SearchView()
        }
        .navigationDestination(isPresented: $viewMenuList) {
            MenuListView(title: "Decorative Light")
        }
    }
}

func menuCustom(title: String, high: CGFloat,action: (() -> Void)? = nil) -> some View {
    Button {
        action?()
    } label: {
        VStack {
            TextSwifUI(title: title, color: .white)
        }
        .padding(4)
        .frame(maxWidth: .infinity)
        .frame(height: high)
        .background(Color.main.cornerRadius(12))
    }
}
