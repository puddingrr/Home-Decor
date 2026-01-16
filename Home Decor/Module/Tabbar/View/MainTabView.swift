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
    @Namespace private var underlineAnimation
    @State private var showLogin = false

    var body: some View {
        VStack(spacing: 0) {
            switch mainVM.tabIndex {
            case 1:
                MenuView()
            case 2:
                CartView()
            case 3:
                EmptyView()
            case 4:
                ProfileView()
                    .environmentObject(mainVM)
            default:
                HomeView()
                    .environmentObject(menuVM)
            }
            Spacer(minLength: 0)
            
            HStack(spacing: 5) {
                ForEach(0..<mainVM.mainTabList.count, id: \.self) { index in
                    TabItemWidget(
                        icon: mainVM.mainTabList[index].icon,
                        activeIcon: mainVM.mainTabList[index].activeIcon,
                        isSelected: mainVM.tabIndex == index,
                        namespace: underlineAnimation
                    ) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            if (index == 2 || index == 4) && !mainVM.isLoggedIn {
                                showLogin = true
                            } else {
                                mainVM.tabIndex = index
                            }                        }
                    }
                }
            }
            .background(Color.white.ignoresSafeArea())
        }
        .navigationDestination(isPresented: $showLogin) {
            LoginView()
        }
        .onAppear {
            mainVM.checkLogin()
            Task {
                    await menuVM.fetchCategory("chair")
                }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
