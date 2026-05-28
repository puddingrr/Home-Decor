//
//  MainTabView.swift
//  Home Decor
//
//  Created by Dalynn on 8/25/25.
//

import SwiftUI

struct MainTabView: View {
    
    @StateObject var mainVM = MainViewModel()
    @StateObject var menuVM = MenuViewModel()
    @StateObject var cartVM = CartViewModel()
    @StateObject var homeVM = HomeViewModel()

    @Namespace private var underlineAnimation
    @State private var showLogin = false
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        VStack(spacing: 0) {
            switch selectedTab {
            case .home:
                HomeView()
                    .environmentObject(homeVM)
                    .environmentObject(menuVM)
                    .environmentObject(cartVM)
            case .shop:
                MenuView()
                    .environmentObject(cartVM)
            case .cart:
                CartView()
                    .environmentObject(menuVM)
                    .environmentObject(cartVM)
            case .profile:
                ProfileView()
                    .environmentObject(mainVM)
            }
            
            TabsLayoutView(selectedTab: $selectedTab)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationDestination(isPresented: $showLogin) {
            LoginView()
        }
        .onAppear {
            mainVM.checkLogin()
            Task {
//                await menuVM.fetchCategory("chair")
                await homeVM.fetchFeaturedProducts()
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
