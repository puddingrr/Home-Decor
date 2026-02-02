//
//  HomeCatecgoryView.swift
//  Home Decor
//
//  Created by Dalynn on 12/22/25.
//

import SwiftUI

struct HomeCatecgoryView: View {
    @StateObject var viewModel: HomeViewModel
    var body: some View {
        HStack {
            ForEach(0..<viewModel.list.count, id: \.self) { i in
                Button {
                    viewModel.selectedIndex = i
                } label: {
                    Rectangle()
                        .fill(viewModel.selectedIndex == i ? Color.darkPink : Color.lightOrange)
                        .cornerRadius(10)
                        .frame(height: 65)
                        .overlay {
                            Image(viewModel.selectedIndex == i ? viewModel.list[i].activeIcon : viewModel.list[i].icon)
                                .resizable()
                                .frame(width: 32, height: 32)
                                .scaledToFit()
                        }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
