//
//  HomeView.swift
//  Home Decor
//
//  Created by Dalynn on 8/25/25.
//

import SwiftUI

struct HomeView: View {
    var isSelected: Bool = false
    @StateObject var viewModel = HomeViewModel()
    @EnvironmentObject var menuVM: MenuViewModel
    @EnvironmentObject var cartVM: CartViewModel
    
    let columns = [
          GridItem(.flexible()),
          GridItem(.flexible())
      ]
    
    var body: some View {
        VStack {
            HStack {
                if !viewModel.isLoggedIn {
                    CustomButton(title: "Login", width: 80, height: 30) {
                        viewModel.navType = .login
                        viewModel.isHomeNavigation = true
                    }
                    CustomButton(title: "SignUp", width: 80, height: 30) {
                        viewModel.navType = .register
                        viewModel.isHomeNavigation = true
                    }
                } else {
                    VStack(alignment: .leading) {
                        TextSwifUI(title: "Hi, Welcome Back", size: .huge, color: .main, weight: Font.Weight.bold)
                        TextSwifUI(title: "Create spaces that bring joy", size: .small, color: .black)
                    }
                }
                Spacer()
                Button {
                    viewModel.navType = .serach
                    viewModel.isHomeNavigation = true
                } label: {
                    Image(.search)
                        .resizable()
                        .frame(width: 31, height: 31)
                }
            }
            .padding(.horizontal, 16)
            .frame(width: UIScreen.main.bounds.width, height: 30)
            .frame(maxWidth: .infinity)
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
                    VStack {
                        TabView(selection: $viewModel.pageIndex) {
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
                            if viewModel.pageIndex < viewModel.animeList.count - 1 {
                                viewModel.pageIndex += 1
                            } else {
                                viewModel.pageIndex = 0
                            }
                        }
                        HStack {
                            ForEach(0..<viewModel.animeList.count, id: \.self) { i in
                                Capsule()
                                    .fill(viewModel.pageIndex == i ? Color.black : Color.main)
                                    .frame(width: viewModel.pageIndex == i ? 25 : 25)
                                    .animation(.easeInOut(duration: 0.6), value: viewModel.pageIndex)
                            }
                        }
                        .frame(height: 6)
                    }
                    HomeCatecgoryView(viewModel: viewModel)
                    VStack(alignment: .leading) {
                        TextSwifUI(title: "Best Seller", size: .medium, color: .selectPink, weight: .bold)
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
                    HomeCollectionView(viewModel: viewModel)
                        .environmentObject(menuVM)
                        .environmentObject(cartVM)
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
            }
        }
        .onAppear {
            if let _ = UserPreference.shared.getLoginData() {
                viewModel.isLoggedIn = true
            }
        }
        .navigationDestination(isPresented: $viewModel.isHomeNavigation) {
            switch viewModel.navType {
            case .serach:
                SearchView()
            case .login:
                LoginView()
            case .register:
                RegisterView()
            case .detailProduct:
                HomeDetailView()
            case .none:
                EmptyView()
            }
        }
    }
}
