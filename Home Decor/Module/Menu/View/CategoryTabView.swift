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
    let menuList: [ListMenu]
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
        VStack {
            WebImage(url: URL(string: image ?? ""))
                .resizable()
                .indicator(.activity)
                .scaledToFill()
                .frame(height: 150)
                .clipped()
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 5) {
                TextSwifUI(title: title, size: .medium, color: .authBg, weight: .medium)
                TextSwifUI(title: subTitle, size: .small, color: .authBg, weight: .light, lineLimit: 1, isScale: false)
                
                HStack {
                    TextSwifUI(title: "$\(price)", size: .large, color: .main, weight: .bold)
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
        }
        .background(Color.darkCardBG.cornerRadius(10))
        .shadow(color: .authBg.opacity(0.05),
                radius: 2, x: 0, y: 2)
        .onTapGesture {
            onClick?()
        }
    }
}
