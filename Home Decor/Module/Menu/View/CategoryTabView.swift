//
//  CategoryTabView.swift
//  Home Decor
//
//  Created by Dalynn on 12/6/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct CategoryTabView: View {
    @StateObject var cateegoryVM: MenuViewModel
    var id: Int
    var title: String
    var onClick: ((ListMenu)-> Void)?
    
    let columns = [
          GridItem(.flexible()),
          GridItem(.flexible())
      ]
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(cateegoryVM.menuList) { index in
                        CardViewMenu(image: index.image,
                                     title: index.title ?? "",
                                     subTitle: index.subTitle ?? "",
                                     price: index.price ?? "",
                                     onClick: {
                            onClick?(index)
                        })
                    }
                }
            }
        }
    }
}

struct CardViewMenu: View {
    var image: String?
    var title: String = ""
    var subTitle: String = ""
    var price: String = ""
    var actionFav: (()-> Void)?
    var actionAdd: (()-> Void)?
    var onClick: (()-> Void)?
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            WebImage(url: URL(string: image ?? ""))
                .resizable()
                .frame(height: 142)
                .clipped()
                .cornerRadius(10)
            
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
        .onTapGesture {
            onClick?()
        }
    }
}
