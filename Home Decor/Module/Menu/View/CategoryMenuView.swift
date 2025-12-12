//
//  BedRoom.swift
//  Home Decor
//
//  Created by Dalynn on 10/22/25.
//

import SwiftUI

struct CategoryMenuView: View {
    @State var search: Bool = false
    @State private var route: CategoryRoute? = nil
    var body: some View {
        VStack {
            CustomNavBar(title: "Bedroom", trailingBtnIcon: .search, isBack: false, actionTrailingIcon: {
                search.toggle()
            })
            VStack {
                VStack {
                    HStack {
                        VStack {
                            menuCustom(title: "Beds", high: 100, action: {
                                route = .menuList(id: 0, title: "Beds")
                            })
                            menuCustom(title: "Light", high: 200) {
                                route = .menuList(id: 1 , title: "Light")
                            }
                            menuCustom(title: "Chairs", high: 130){
                                route = .menuList(id: 2 , title: "Chairs")
                            }
                        }
                        VStack {
                            menuCustom(title: "Sofa", high: 130) {
                                route = .menuList(id: 3 , title: "Sofa")
                            }
                            menuCustom(title: "Tables", high: 130) {
                                route = .menuList(id: 4 , title: "Tables")
                            }
                            menuCustom(title: "Cupboard", high: 170) {
                                route = .menuList(id: 5 , title: "Cupboard")
                            }
                        }
                    }
                    menuCustom(title: "Decor", high: 120) {
                        route = .menuList(id: 6 , title: "Decor")
                    }
                }
            }
            .padding(16)
        }
        .navigationDestination(isPresented: $search) {
            SearchView()
        }
        .navigationDestination(item: $route) { route in
            switch route {
            case .search:
                SearchView()

            case .menuList(let id, let title):
                MenuListView(id: id, title: title)
            }
        }
    }
}

enum CategoryRoute: Hashable {
    case search
    case menuList(id: Int, title: String)
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
