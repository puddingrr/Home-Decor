//
//  HomeCollectionView.swift
//  Home Decor
//
//  Created by Dalynn on 12/22/25.
//

import SwiftUI

struct HomeCollectionView: View {
    @StateObject var viewModel: HomeViewModel
    @State var selectedItem: ListMenu?
    @State var showDetail = false
    var body: some View {
        VStack(alignment: .leading) {
            TextSwifUI(title: "New Collection", size: .medium, color: .selectPink, weight: .bold)
            HStack(spacing: 24) {
                ForEach(viewModel.collectList, id: \.id) { item in
                    VStack(alignment: .leading, spacing: 10) {
                        Image(item.image)
                            .resizable()
                            .frame(height: 142)
                            .scaledToFill()
                        TextSwifUI(title: item.title, size: .large, weight: .medium)
                        TextSwifUI(title: item.subTitle, size: .small, weight: .light)
                        Divider()
                            .frame(height: 1)
                            .background(Color.main)
                        HStack {
                            TextSwifUI(title: "$\(item.price)", size: .large, color: .selectPink, weight: .bold)
                            Spacer(minLength: 0)
                            Button {
                                
                            } label: {
                                Image(.iconFav)
                                    .frame(width: 20, height: 20)
                            }
                            Button {
                                
                            } label: {
                                Image(.iconAdd)
                                    .frame(width: 20, height: 20)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        selectedItem = item
                        showDetail = true
                    }
                }
            }
        }
        .navigationDestination(isPresented: $showDetail) {
            if let item = selectedItem {
                HomeDetailView(item: item)
            }
        }
    }
}
