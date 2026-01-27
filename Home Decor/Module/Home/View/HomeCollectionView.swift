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
                    VStack(alignment: .leading, spacing: 10) {
                        WebImage(url: URL(string: item.image ?? ""))
                            .resizable()
                            .indicator(.activity)
                            .scaledToFill()
                            .frame(height: 142)
                            .clipped()
                            .cornerRadius(10)

                        TextSwifUI(title: item.title ?? "", size: .large, weight: .medium)
                        TextSwifUI(title: item.subTitle ?? "", size: .small, weight: .light)

                        Divider()
                            .frame(height: 1)
                            .background(Color.main)

                        HStack {
                            TextSwifUI(title: "$\(item.price ?? "")", size: .large, color: .selectPink, weight: .bold)
                            Spacer()
                            Image(.iconFav)
                            Image(.iconAdd)
                        }
                    }
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
