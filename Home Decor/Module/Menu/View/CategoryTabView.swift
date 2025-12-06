//
//  CategoryTabView.swift
//  Home Decor
//
//  Created by Dalynn on 12/6/25.
//

import SwiftUI
struct CategoryTabView: View {
    @StateObject var categoryVM: CategoryViewModel
    var title: String
    
    let columns = [
          GridItem(.flexible()),
          GridItem(.flexible())
      ]
    
    var body: some View {
        VStack {
            CustomNavBar(title: title, trailingBtnIcon: .search)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(categoryVM.list.indices, id: \.self) { item in
                        let i = categoryVM.list[item]
                        CardViewMenu(image: i.image,
                                     title: i.title,
                                     subTitle: i.subTitle,
                                     price: i.price
                        )
                    }
                }
                .padding()
            }
        }
    }
}

struct CardViewMenu: View {
    var image: ImageResource
    var title: String = ""
    var subTitle: String = ""
    var price: String = ""
    var actionFav: (()-> Void)?
    var actionAdd: (()-> Void)?
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(image)
                .resizable()
                .frame(height: 142)
                .scaledToFill()
            TextSwifUI(title: title, size: .large, weight: .medium)
            TextSwifUI(title: subTitle, size: .small, weight: .light)
            Divider()
                .frame(height: 1)
                .background(Color.main)
            HStack {
                TextSwifUI(title: price, size: .large, color: .selectPink, weight: .bold)
                Spacer(minLength: 0)
                Button {
                    actionFav?()
                } label: {
                    Image(.iconFav)
                        .frame(width: 20, height: 20)
                }
                Button {
                    actionAdd?()
                } label: {
                    Image(.iconAdd)
                        .frame(width: 20, height: 20)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
