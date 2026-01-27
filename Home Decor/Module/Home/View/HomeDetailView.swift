//
//  HomeDetailView.swift
//  Home Decor
//
//  Created by Dalynn on 12/22/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeDetailView:View {
    @EnvironmentObject var cartVM: CartViewModel
    
    @State var showAlreadyAddedAlert = false

    var item: ListMenu?
    var actionFav: (()-> Void)?
    var actionAdd: (()-> Void)?
        
    var body: some View {
            VStack(spacing: 0) {
                CustomNavBar(title: "Product Detail")
                RoundedRectangle(cornerRadius: 0)
                    .frame(height: 1)
                    .foregroundColor(Color.gray.opacity(0.3))
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.lightOrange)
                            if  let image = item?.image {
                                GeometryReader { geo in
                                    WebImage(url: URL(string: image))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: geo.size.width, height: geo.size.height)
                                        .clipped()
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .frame(height: 270)
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
                        .padding(.top, 32)
                        .alert("Already in Cart 💜", isPresented: $showAlreadyAddedAlert) {
                            Button("OK", role: .cancel) { }
                        } message: {
                            Text("This product is already added to your cart.")
                        }
                    }
                    .padding(16)
                }
                Spacer()
            }
    }
}
