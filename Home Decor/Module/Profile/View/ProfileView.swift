//
//  ProfileView.swift
//  Home Decor
//
//  Created by Dalynn on 8/28/25.
//
import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    var body: some View {
        VStack {
            CustomNavBar(title: "My Profile", tinhColor: .main, trailingBtnIcon: .edit, isBack: false, actionTrailingIcon: {
                viewModel.isSelectedEdit.toggle()
            })
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 100)
                        .overlay {
                            Image(.myprofile)
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    VStack {
                        TextSwifUI(title: "Madison Smith", size: .huge, weight: .bold)
                        TextSwifUI(title: "ID: 25030024", size: .small)
                    }
                    HStack {
                        menuCard(image: .myprofile, text: "Profile") {}
                        menuCard(image: .wishlistActive, text: "Wishlist") {}
                        menuCard(image: .myOrder, text: "My Orders", isLast: false) {
                            viewModel.isOrder.toggle()
                        }
                    }
                    .padding(.vertical, 12)
                    .cornerRadius(20)
                    .frame(height: 81)
                    .background(Color.main.cornerRadius(16))
                }
                .padding(16)
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(viewModel.listMenu.indices, id: \.self) { i in
                        menuList(image: viewModel.listMenu[i].image, text: viewModel.listMenu[i].text) {
                            viewModel.isSelected = i
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            Spacer()
        }
        .navigationDestination(isPresented: $viewModel.isOrder) {
            MyOrderView(viewModel: viewModel)
        }
        .navigationDestination(isPresented: $viewModel.isSelectedEdit) {
            EditProfileView(viewModel: viewModel)
        }
    }
    @ViewBuilder
    func menuCard(image: ImageResource, text: String, isLast: Bool = true, action: (()-> Void)?) -> some View {
        Button {
            action?()
        } label: {
            VStack(spacing: 8) {
                Image(image)
                    .resizable()
                    .frame(width: 26, height: 26)
                TextSwifUI(title: text, size: .small, weight: .regular)
            }
            .frame(maxWidth: .infinity)
        }
        if isLast {
            Divider()
                .frame(width: 1)
                .background(Color.white)
        }
    }
    @ViewBuilder
    func menuList(image: ImageResource, text: String, action: (() -> Void)?) -> some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(Color.main)
                    .frame(width: 34, height: 34)
                    .overlay {
                        Image(image)
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
            }
            TextSwifUI(title: text, size: .large)
            Spacer()
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
        }
    }
}

struct MenuList {
    let image: ImageResource
    let text: String
}

