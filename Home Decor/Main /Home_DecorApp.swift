//
//  Home_DecorApp.swift
//  Home Decor
//
//  Created by Dalynn on 8/25/25.
//

import SwiftUI

@main
struct Home_DecorApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MainTabView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .preferredColorScheme(.light)
        }
    }
}
