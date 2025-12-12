//
//  MenuListView.swift
//  Home Decor
//
//  Created by Dalynn on 12/6/25.
//

import SwiftUI

struct MenuListView: View {
    @StateObject var categoryVM = CategoryViewModel()
    @State var isNavigationDetail: Bool = false
    @State private var selectedItem: ListMenu?
    // varible
    let id: Int
    var title: String
    var body: some View {
        VStack {
            headerView
            HStack {
                TabView(selection: $categoryVM.indexTab) {
                    ForEach(categoryVM.itemsTab.indices, id: \.self) { index in
                        CategoryTabView(categoryVM: categoryVM, id: index, title: title) { item in
                            selectedItem = item
                            isNavigationDetail = true
                        }
                            .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
            .padding(.horizontal, 16)
        }
        .onAppear {
          categoryVM.indexTab = id
        }
        .navigationDestination(isPresented: $isNavigationDetail) {
            if selectedItem != nil {
                CategoryDetailView(categoryVM: categoryVM, title: title, item: selectedItem)
            }
        }
    }
}
extension MenuListView {
    var headerView: some View {
        VStack(spacing: 0) {
            CustomNavBar(title: title, trailingBtnIcon: .search)

            HStack(spacing: 16) {
                ScrollView(.horizontal, showsIndicators: false) {
                    CustomMenuTab(index: $categoryVM.indexTab , items: categoryVM.itemsTab)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 0, trailing: 16))
            RoundedRectangle(cornerRadius: 0)
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.3))
        }
    }
}
