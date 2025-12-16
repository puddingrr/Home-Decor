//
//  MainTabView.swift
//  Home Decor
//
//  Created by Dalynn on 8/25/25.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var mainVM = MainViewModel()
    @Namespace private var underlineAnimation

    var body: some View {
        VStack(spacing: 0) {
            switch mainVM.tabIndex {
            case 1:
                CategoryMenuView()
            case 2:
                CartView()
            case 3:
                EmptyView()
            case 4:
                ProfileView()
            default:
                HomeView()
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
                            mainVM.tabIndex = index
                        }
                    }
                }
            }
            .background(Color.white.ignoresSafeArea())
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
