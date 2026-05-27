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
    
    let menuList: [ListMenu]
    @State var selectedItem: ListMenu?
//    var onClick: ((ListMenu)-> Void)?
    @State var showDetail = false
    
    var actionFav: (()-> Void)?
    var actionAdd: (()-> Void)?
    var action: (()-> Void)?
    
    let columns = [
          GridItem(.flexible()),
          GridItem(.flexible())
      ]
    
    var body: some View {
        VStack(alignment: .leading) {
            TextSwifUI(title: "New Collection", size: .medium, color: Color.authBg, weight: .bold)
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(menuList) { item in
                    VStack {
                        WebImage(url: URL(string: item.image ?? ""))
                            .resizable()
                            .indicator(.activity)
                            .scaledToFill()
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(10)

                        VStack(alignment: .leading, spacing: 5) {
                            TextSwifUI(title: item.title ?? "", size: .medium, color: .authBg, weight: .medium)
                            TextSwifUI(title: item.subTitle ?? "", size: .small, color: .authBg, weight: .light, lineLimit: 1, isScale: false)
                            
                            HStack {
                                TextSwifUI(title: "$\(item.price ?? "")", size: .large, color: .main, weight: .bold)
                                Spacer()
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
                    }
                    .background(Color.darkCardBG.cornerRadius(10))
                    .shadow(color: .authBg.opacity(0.05),
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
