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
    var itemProduct: ProductModel?
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
                        if !productImage.isEmpty {
                            WebImage(url: URL(string: productImage))
                                .resizable()
                                .scaledToFill()
                                .frame(height: 230)
                                .clipped()
                                .cornerRadius(10)
                        }
                        TextSwifUI(title: productTitle, size: .large, weight: .medium)
                        TextSwifUI(title: productDescription, size: .small, weight: .light)
                        Color.gray.opacity(0.3)
                            .frame(height: 1)
                        HStack {
                            TextSwifUI(title: productPrice, size: .large, color: .red, weight: .bold)
                            Spacer(minLength: 0)
                            Button {
                                actionFav?()
                            } label: {
                                Image(.iconFav)
                                    .frame(width: 20, height: 20)
                            }
                        }
                        HStack {
                            TextSwifUI(title: "Users reviews")
                            Spacer(minLength: 0)
                            StarRatingView(rating: 4)
                        }
                        
                        CustomButton(title: "Add to Cart") {
                            var cartItem: ListMenu?

                            if let item = item {
                                cartItem = item
                            } else if let product = itemProduct {
                                cartItem = ListMenu(
                                    id: product.id ?? "",
                                    image: product.imageURL,
                                    title: product.name,
                                    subTitle: product.description,
                                    price: "\(product.price ?? 0)"
                                )
                            }

                            guard let finalItem = cartItem else { return }

                            let added = cartVM.addToCart(finalItem)
                            if !added {
                                showAlreadyAddedAlert = true
                            }
                        }
                        .padding(.top, 32)
                        .alert("Already in Cart", isPresented: $showAlreadyAddedAlert) {
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
extension HomeDetailView {
    var productTitle: String {
        if let item = item {
            return item.title ?? ""
        }
        if let product = itemProduct {
            return product.name ?? ""
        }
        return ""
    }
    var productDescription: String {
        if let item = item {
            return item.subTitle ?? ""
        }
        if let product = itemProduct {
            return product.description ?? ""
        }
        return ""
    }
    var productPrice: String {
        if let item = item {
            return item.price ?? ""
        }
        if let product = itemProduct {
            return "$\(product.price ?? 0)"
        }
        return ""
    }
    var productImage: String {
        if let item = item {
            return item.image ?? ""
        }
        if let product = itemProduct {
            return product.imageURL ?? ""
        }
        return ""
    }
}
