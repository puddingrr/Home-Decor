//
//  CartView.swift
//  Home Decor
//
//  Created by Dalynn on 12/15/25.
//

import SwiftUI

struct CartView: View {
    var body: some View {
        VStack  {
            CustomNavBar(title: "My Cart", trailingBtnIcon: .edit)
            
            VStack {
                HStack(alignment: .top, spacing: 5) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 69, height: 69)
                            .foregroundColor(Color.lightOrange)
                        Image(.dresser)
                            .resizable()
                            .frame(width: 89, height: 89)
                     }
                    VStack(alignment: .leading) {
                        TextSwifUI(title: "Bedroom Dresser", size: .other(16), color: .selectPink)
                        TextSwifUI(title: "750$", size: .other(16))
                    }
                    Spacer(minLength: 0)
                    HStack(spacing: 8) {
                        Image(.dicrease)
                            .resizable()
                            .frame(width: 24, height: 24)
                        TextSwifUI(title: "1", weight: .bold)
                        Image(.increase)
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
            }
            .padding(.top, 32)
            .padding()
        }
    }
}


struct NoDataView: View {
    var body: some View {
        VStack {
            Image(.cart)
                .resizable()
                .frame(width: 200, height: 200)
            TextSwifUI(title: "There are no items in your cart", size: .other(28), weight: .bold)
        }
    }
}
