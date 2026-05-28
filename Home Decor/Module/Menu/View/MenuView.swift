//
//  BedRoom.swift
//  Home Decor
//
//  Created by Dalynn on 10/22/25.
//
import SwiftUI
import SDWebImageSwiftUI

struct MenuView: View {
    @StateObject var menuVM = MenuViewModel()
    @EnvironmentObject var cartVM: CartViewModel
    
    @State private var selectedItem: ListMenu? = nil
    @State private var isNavigationDetail: Bool = false
    @State private var isNavSearch: Bool = false
    
    var body: some View {
        VStack {
            // Header
            headerView
            
            // TabView for categories
            TabView(selection: $menuVM.indexTab) {
                ForEach(menuVM.itemsTab.indices, id: \.self) { index in
                    CategoryTabView(cateegoryVM: menuVM, id: index, title: menuVM.itemsTab[index], menuList: menuVM.menuList) { item in
                        selectedItem = item
                        isNavigationDetail = true
                    }
                    .tag(index)
                    .task {
                        let categoryKey = mapTabIndexToCategoryKey(index)
                        await menuVM.fetchCategory(categoryKey)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .padding(.horizontal, 16)
        }
        .onAppear {
            menuVM.indexTab = 0
            Task {
//                await menuVM.fetchCategory(mapTabIndexToCategoryKey(0))
            }
        }
        .navigationDestination(isPresented: $isNavigationDetail) {
            if let item = selectedItem {
                HomeDetailView(item: item)
                    .environmentObject(cartVM)
            }
        }
        .navigationDestination(isPresented: $isNavSearch) {
           SearchView()
        }
    }
}

// MARK: Header
extension MenuView {
    var headerView: some View {
        VStack(spacing: 0) {
            CustomNavBar(title: "Bedroom", background: Color.clear, trailingBtnIcon: "magnifyingglass", isBack: false, actionTrailingIcon: {
                isNavSearch = true
            })
            
            VStack(alignment: .center, spacing: 0) {
                HStack(spacing: 16) {
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
                        CustomMenuTab(index: $menuVM.indexTab, items: menuVM.itemsTab)
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                RoundedRectangle(cornerRadius: 0)
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.3))
            }
            .padding(.vertical, 8)
        }
    }
}

// MARK: Map Tab Index to Firestore Collection
extension MenuView {
    func mapTabIndexToCategoryKey(_ index: Int) -> String {
        switch index {
        case 0: return "bed"
        case 1: return "chair"
        case 2: return "desk"
        case 3: return "sofa"
        case 4: return "table"
        default: return "bed"
        }
    }
}
