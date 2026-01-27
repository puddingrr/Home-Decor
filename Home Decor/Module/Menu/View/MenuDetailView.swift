//
//  CategoryDetailView.swift
//  Home Decor
//
//  Created by Dalynn on 12/12/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct MenuDetailView: View {
    @StateObject var categoryVM: MenuViewModel
    @EnvironmentObject var cartVM: CartViewModel
    
    @State var showAlreadyAddedAlert = false
    
    var title: String
    var item: ListMenu?
    var actionFav: (()-> Void)?
    var actionAdd: (()-> Void)?
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(title: title,trailingBtnIcon: .search, isShadow: true)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 270)
                            .foregroundColor(Color.lightOrange)
                        if  let image = item?.image {
                            WebImage(url: URL(string: image))
                                .resizable()
                                .frame(height: 230)
                        }
                    }
                    TextSwifUI(title: item?.title ?? "", size: .large, weight: .medium)
                    TextSwifUI(title: item?.subTitle ?? "", size: .small, weight: .light)
                    Divider()
                        .frame(height: 1)
                        .background(Color.main)
                    HStack {
                        TextSwifUI(title: item?.price ?? "", size: .large, color: .selectPink, weight: .bold)
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
                    HStack {
                        TextSwifUI(title: "Users reviews")
                        Spacer(minLength: 0)
                        StarRatingView(rating: 4)
                    }
                    
                    CustomButton(title: "Add to Cart") {
                        if let productItem = item {
                            Task {
                                let added = await cartVM.addToCart(productItem)
                                if !added {
                                    showAlreadyAddedAlert = true
                                }
                            }
                        }
                    }
                    .alert("Already in Cart 💜", isPresented: $showAlreadyAddedAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("This product is already added to your cart.")
                    }
                }.padding(16)
            }
        }
    }
}
import SwiftUI

struct StarRatingView: View {
    var rating: CGFloat
    var maxRating: Int = 5
    var size: CGFloat = 16
    
    var body: some View {
        // Background: empty stars
        ZStack(alignment: .leading) {
            HStack(spacing: 0) {
                ForEach(0..<maxRating, id: \.self) { _ in
                    Image(.starNotActive)
                        .resizable()
                        .frame(width: size, height: size)
                }
            }
            
            // Foreground: filled stars
            HStack(spacing: 0) {
                ForEach(0..<maxRating, id: \.self) { _ in
                    Image(.starActive)
                        .resizable()
                        .frame(width: size, height: size)
                }
            }
            // Mask only the needed width
            .mask(
                HStack(spacing: 5) {
                    Spacer(minLength: 0)
                    Rectangle()
                        .frame(width: size * rating)
                }
            )
        }
    }
}
