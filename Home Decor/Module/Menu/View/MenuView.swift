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
                    CategoryTabView(cateegoryVM: menuVM, id: index, title: menuVM.itemsTab[index]) { item in
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
                await menuVM.fetchCategory(mapTabIndexToCategoryKey(0))
            }
        }
        // Navigate to detail when an item is tapped
        .navigationDestination(isPresented: $isNavigationDetail) {
            if let item = selectedItem {
                MenuDetailView(categoryVM: menuVM, title: selectedItem?.title ?? "", item: item)
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
            CustomNavBar(title: "Bedroom", background: Color.clear, trailingBtnIcon: .search, isBack: false, actionTrailingIcon: {
                isNavSearch = true
            })
            
            HStack(spacing: 16) {
                ScrollView(.horizontal, showsIndicators: false) {
                    CustomMenuTab(index: $menuVM.indexTab, items: menuVM.itemsTab)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            RoundedRectangle(cornerRadius: 0)
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.3))
        }
    }
}

// MARK: Map Tab Index to Firestore Collection
extension MenuView {
    func mapTabIndexToCategoryKey(_ index: Int) -> String {
        switch index {
        case 0: return "bed"
        case 1: return "sofa"
        case 2: return "chair"
        case 3: return "Table"
        case 4: return "auxiliary"
        case 5: return "desk"
        default: return "bed"
        }
    }
}
