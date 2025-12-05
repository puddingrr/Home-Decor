//
//  Home_DecorApp.swift
//  Home Decor
//
//  Created by Dalynn on 8/25/25.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    FirebaseConfiguration.shared.setLoggerLevel(.debug)
    return true
  }
}

@main
struct Home_DecorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
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

