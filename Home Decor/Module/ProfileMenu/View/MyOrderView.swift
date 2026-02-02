//
//  MyOrderView.swift
//  Home Decor
//
//  Created by Dalynn on 8/29/25.
//

import SwiftUI

struct MyOrderView: View {
    @StateObject var viewModel: ProfileViewModel
    var body: some View {
        VStack {
            CustomNavBar(title: "My Orders", tinhColor: .main)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    ForEach(viewModel.listOrder.indices, id: \.self) { i in
                        let model = viewModel.listOrder[i]
                        orderCard(model: model)
                    }
                    .padding(.top, 30)
                }
            }
            .padding(.horizontal, 16)
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct orderCard: View {
    let model: orderList
    var body: some View {
        VStack(spacing: 6) {
            HStack {
                TextSwifUI(title: "Order: \(model.status)", size: .small, weight: .light)
                Spacer()
                TextSwifUI(title: model.date, size: .small, weight: .light)
            }
            Divider()
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .background(Color.main)
            HStack {
                Image(model.image)
                    .resizable()
                    .frame(width: 89, height: 89)
                VStack {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            TextSwifUI(title: model.title, size: .medium, color: .selectPink, weight: .medium)
                            TextSwifUI(title: model.subTitle, size: .small, weight: .light)
                        }
                        Spacer()
                        HStack {
                            Image(.delete)
                                .resizable()
                                .frame(width: 19, height: 19)
                            Image(.iconAdd)
                                .resizable()
                                .frame(width: 19, height: 19)
                        }
                    }
                    HStack {
                        TextSwifUI(title: "$\(model.price)", weight: .regular)
                        Spacer()
                        TextSwifUI(title: "\(model.item)x uds.", weight: .regular)
                        Spacer()
                        TextSwifUI(title: "Total: $\(model.totalPrice)", weight: .regular)
                    }
                }
            }
        }
    }
}
