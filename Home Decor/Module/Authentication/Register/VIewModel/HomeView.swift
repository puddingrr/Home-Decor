//
//  HomeView.swift
//  Home Decor
//
//  Created by Dalynn on 8/25/25.
//

import SwiftUI

struct HomeView: View {
    @State var pageIndex: Int = 0
    var isSelected: Bool = false
    @State var search: Bool = false
    @StateObject var viewModel = HomeViewModel()
    @State var isNavLogin: Bool = false
    @State var isNavRegister: Bool = false
    @State private var isLoggedIn: Bool = false
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        if !isLoggedIn {
                            CustomButton(title: "Login", width: 80, height: 30) {
                                isNavLogin = true
                            }
                            CustomButton(title: "SignUp", width: 80, height: 30) {
                                isNavRegister = true
                            }
                        } else {
                            VStack(alignment: .leading) {
                                TextSwifUI(title: "Hi, Welcome Back", size: .huge, color: .main, weight: Font.Weight.bold)
                                TextSwifUI(title: "Create spaces that bring joy", size: .small, color: .black)
                            }
                        }
                        Spacer()
                        Button {
                            search.toggle()
                        } label: {
                            Image(.search)
                                .resizable()
                                .frame(width: 31, height: 31)
                        }
                    }
                    VStack {
                        TabView(selection: $pageIndex) {
                            ForEach(0..<viewModel.animeList.count, id: \.self) { i in
                                HStack {
                                    Image(viewModel.animeList[i])
                                        .resizable()
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 140)
                                        .cornerRadius(10)
                                }
                                .tag(i)
                            }
                        }
                        .frame(height: 140)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .onReceive(Timer.publish(every: 2, on: .main, in: .common).autoconnect()) { _ in
                            if pageIndex < viewModel.animeList.count - 1 {
                                pageIndex += 1
                            } else {
                                pageIndex = 0
                            }
                        }
                        HStack {
                            ForEach(0..<viewModel.animeList.count, id: \.self) { i in
                                Capsule()
                                    .fill(pageIndex == i ? Color.black : Color.main)
                                    .frame(width: pageIndex == i ? 25 : 25)
                                    .animation(.easeInOut(duration: 0.6), value: pageIndex)
                            }
                        }
                        .frame(height: 6)
                    }
                    TextSwifUI(title: "Categories", size: .large, color: .selectPink, weight: .bold)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(0..<viewModel.list.count, id: \.self) { i in
                                menuList(icon: viewModel.list[i].icon,
                                         activeIcon: viewModel.list[i].activeIcon,
                                         isSelected: viewModel.selectedIndex == i) {
                                    viewModel.selectedIndex = i
                                }
                            }
                        }
                    }
                    TextSwifUI(title: "Best Seller", size: .medium, color: .selectPink, weight: .bold)
                    bestSeller
                    TextSwifUI(title: "New Collection", size: .medium, color: .selectPink, weight: .bold)
                    collectionView
                }
                .padding(16)
            }
        }
        .onAppear {
            if let _ = UserPreference.shared.getLoginData() {
                isLoggedIn = true
            }
        }
        .navigationDestination(isPresented: $search) {
            SearchView()
        }
        .navigationDestination(isPresented: $isNavLogin) {
            LoginView()
        }
        .navigationDestination(isPresented: $isNavRegister) {
            RegisterView()
        }
//        .task {
//            await ProductSeeder.seedSampleProducts()
//        }
    }
    @ViewBuilder
    func menuList(icon: ImageResource, activeIcon: ImageResource, isSelected: Bool, action: (() -> Void)? = nil) -> some View {
        Button {
            action?()
        } label: {
            Rectangle()
                .fill(isSelected ? Color.darkPink : Color.lightOrange)
                .cornerRadius(10)
                .frame(width: 65, height: 65)
                .overlay {
                    Image(isSelected ? activeIcon : icon)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .scaledToFit()
                }
        }
    }
    var bestSeller: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    TextSwifUI(title: "Kitchen Cart", size: .large, color: .black)
                    TextSwifUI(title: "Lorem ipsum dolor sit amet, \nconsectetur adipiscing elit", size: .medium, color: .black)
                    HStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                            .frame(width: 60, height: 20)
                            .overlay {
                                HStack(spacing: 8) {
                                    Image(systemName: "star.fill")
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.darkPink)
                                    
                                    TextSwifUI(title: "4.5", color: .black, weight: .bold)
                                }
                            }
                        TextSwifUI(title: "Shop Now", size: .small, color: .black)
                            .padding(4)
                            .background(Color.white.cornerRadius(8))
                            .padding(.leading, 16)
                    }
                }
                .padding(12)
                Spacer()
            }
            .background(Color.darkPink.cornerRadius(12))
            .frame(maxWidth: .infinity)
            .frame(height: 100)

            Image(.bestSelling)
                .resizable()
                .frame(width: 171, height: 171)
                .padding(.top, -60)
        }
        .padding(.top, 25)
    }
    var collectionView: some View {
        HStack(spacing: 24) {
            ForEach(0..<viewModel.collectList.count, id: \.self) { i in
                VStack(alignment: .leading, spacing: 10) {
                    Image(viewModel.collectList[i].image)
                        .resizable()
                        .frame(height: 142)
                        .scaledToFill()
                    TextSwifUI(title: viewModel.collectList[i].title, size: .large, weight: .medium)
                    TextSwifUI(title: viewModel.collectList[i].subTitle, size: .small, weight: .light)
                    Divider()
                        .frame(height: 1)
                        .background(Color.main)
                    HStack {
                        TextSwifUI(title: "$\(viewModel.collectList[i].price)", size: .large, color: .selectPink, weight: .bold)
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
            }
        }
    }
}
