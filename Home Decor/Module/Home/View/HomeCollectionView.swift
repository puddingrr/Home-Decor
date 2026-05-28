//
//  HomeCollectionView.swift
//  Home Decor
//
//  Created by Dalynn on 12/22/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeCollectionView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @EnvironmentObject var cartVM: CartViewModel
    
    let featureProduct: [ProductModel]
    @State var selectedItem: ProductModel?
    @State var showDetail = false
    
    var actionFav: (()-> Void)?
    var action: (()-> Void)?
    
    let columns = [
          GridItem(.flexible()),
          GridItem(.flexible())
      ]
    
    var body: some View {
        VStack(alignment: .leading) {
            TextSwifUI(title: "New Collection", size: .medium, color: Color.authBg, weight: .bold)
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(featureProduct) { item in
                    VStack {
                        WebImage(url: URL(string: item.imageURL ?? ""))
                            .resizable()
                            .indicator(.activity)
                            .scaledToFill()
                            .frame(height: 150)
                            .clipped()
                            .cornerRadius(10)

                        VStack(alignment: .leading, spacing: 5) {
                            TextSwifUI(title: item.name ?? "", size: .medium, color: .authBg, weight: .medium)
                            TextSwifUI(title: item.description ?? "", size: .small, color: .authBg, weight: .light, lineLimit: 1, isScale: false)
                            
                            HStack {
                                TextSwifUI(title: "$\(item.price ?? 0)", size: .large, color: .main, weight: .bold)
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
                HomeDetailView(itemProduct: item)
                    .environmentObject(cartVM)
                    .environmentObject(viewModel)
            }
        }
    }
}
