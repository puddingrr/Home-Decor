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
    
    @State var contentOffset: CGPoint?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.appBackground.ignoresSafeArea()
            ZStack(alignment: .top) {
                Color.main.ignoresSafeArea()
                    .frame(height: 150)
                    .frame(maxWidth: .infinity)
                VStack(spacing: 0) {
                    homeHeader
                    ScrollViewReader { proxy in
                        ScrollView(showsIndicators: false) {
                            GeometryReader { geo in
                                Color.clear
                                    .onChange(of: geo.frame(in: .global).minY) { scrollOffset in
                                        contentOffset = nil // reset it to make action scroll to offset work
                                    }
                            }
                            .frame(height: 0)
                            LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                                ZStack(alignment: .top) {
                                    Color.main.ignoresSafeArea()
                                    BannerView(images: viewModel.animeList)
                                }
                                Section {
                                    VStack(spacing: 16) {
                                        bestCeller
                                        HomeCollectionView(viewModel: viewModel)
                                            .environmentObject(menuVM)
                                            .environmentObject(cartVM)
                                    }
                                    .padding(.top, 16)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, viewModel.isLoggedIn == false ? 60 : 16)
                                } header: {
                                    VStack(spacing: 8) {
                                        HomeCatecgoryView(viewModel: viewModel)
                                        HStack(spacing: 20) {
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                CustomMenuTab(index: $viewModel.indexTab, items: viewModel.itemsTab, textColor: .cream.opacity(0.8),
                                                              textColorselected: .white)
                                            }
                                        }
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(Color.main)
                                }
                            }
                            .scrollToOffset(contentOffset: $contentOffset)
                        }
                    }
                }
            }
            VStack(spacing: 0) {
                Spacer()
                panelAuthView
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

extension HomeView {
    var homeHeader: some View {
        HStack {
            VStack(alignment: .leading) {
                TextSwifUI(title: "Hi, Welcome Back", size: .huge, color: .white, weight: .bold)
                TextSwifUI(title: "Create spaces that bring joy", size: .small, color: .white)
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
        .frame(width: UIScreen.main.bounds.width, height: 45)
        .frame(maxWidth: .infinity)
        .background(.main)
    }
    
    var bestCeller: some View {
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
    }
}
