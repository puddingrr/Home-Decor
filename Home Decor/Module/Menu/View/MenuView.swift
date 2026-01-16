//
//  BedRoom.swift
//  Home Decor
//
//  Created by Dalynn on 10/22/25.
//
import SwiftUI
import SDWebImageSwiftUI

struct MenuView: View {
    @StateObject var menuVM = MenuViewModel() // single source of truth
    
    @State private var selectedItem: ListMenu? = nil
    @State private var isNavigationDetail: Bool = false
    
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
            }
        }
    }
}

// MARK: Header
extension MenuView {
    var headerView: some View {
        VStack(spacing: 0) {
            CustomNavBar(title: "Bedroom", trailingBtnIcon: .search, isBack: false) {
                menuVM.navigate(.search)
            }
            
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
        case 1: return "chair"
        case 2: return "sofa"
        case 3: return "Table"
        case 4: return "desk"
        case 5: return "auxiliary"
        default: return "bed"
        }
    }
}

// MARK: Custom menu button
func menuCustom(title: String, high: CGFloat, action: (() -> Void)? = nil) -> some View {
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
