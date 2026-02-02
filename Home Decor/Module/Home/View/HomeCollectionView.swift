//
//  HomeCollectionView.swift
//  Home Decor
//
//  Created by Dalynn on 12/22/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeCollectionView: View {
    @StateObject var viewModel: HomeViewModel
    @EnvironmentObject var menuVM: MenuViewModel
    @EnvironmentObject var cartVM: CartViewModel
    
    @State var selectedItem: ListMenu?
    @State var showDetail = false
    
    let columns = [
          GridItem(.flexible()),
          GridItem(.flexible())
      ]
    
    var body: some View {
        VStack(alignment: .leading) {
            TextSwifUI(title: "New Collection", size: .medium, color: .selectPink, weight: .bold)
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(menuVM.menuList) { item in
                    VStack {
                        WebImage(url: URL(string: item.image ?? ""))
                            .resizable()
                            .indicator(.activity)
                            .scaledToFill()
                            .frame(height: 150)
                            .cornerRadius(10, corners: [.topLeft, .topRight])
                            .clipped()

                        VStack(alignment: .leading, spacing: 5) {
                            TextSwifUI(title: item.title ?? "", size: .medium, weight: .medium)
                            TextSwifUI(title: item.subTitle ?? "", size: .small, weight: .light, lineLimit: 1, isScale: false)
                            
                            HStack {
                                TextSwifUI(title: "$\(item.price ?? "")", size: .large, color: .main, weight: .bold)
                                Spacer()
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                    }
                    .background(Color.white.cornerRadius(10))
                    .shadow(color: .black.opacity(0.05),
                            radius: 2, x: 0, y: 2)
                    .onTapGesture {
                        selectedItem = item
                        showDetail = true
                    }
                }
            }
        }
        .navigationDestination(isPresented: $showDetail) {
            if let item = selectedItem {
                HomeDetailView(item: item)
                    .environmentObject(cartVM)
            }
        }
    }
}
