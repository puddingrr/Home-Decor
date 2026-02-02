//
//  ProfileIconView.swift
//  Home Decor
//
//  Created by Dalynn on 12/19/25.
//
import SwiftUI
import SDWebImageSwiftUI

struct ProfileIconView: View {
    @StateObject var viewModel: EditProfileViewModel
    let onSelect: (String) -> Void

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            CustomNavBar(title: "Select Profile", isBack: false)

            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.list) { icon in
                        ForEach(icon.imageURLs, id: \.self) { urlString in
                            if let url = URL(string: urlString) {
                                WebImage(url: url)
                                    .resizable()
                                    .indicator(.activity)
                                    .scaledToFill()
                                    .frame(width: 120, height: 120)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .onTapGesture {
                                        onSelect(urlString) // ⭐ send back
                                    }
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.fetchIcons()
        }
    }
}
