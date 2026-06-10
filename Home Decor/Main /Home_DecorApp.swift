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
    FirebaseConfiguration.shared.setLoggerLevel(.warning)
    FirebaseApp.configure()
    return true
  }
}

@main
struct Home_DecorApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("appTheme") private var appTheme = 0
    
    init() {
        LogWriter.shared.log("App launched")
        FirebaseLog.shared.logFirebase(.fetch, collection: "featuredProducts")
        FirebaseLog.shared.logFirebase(.success, collection: "featuredProducts", count: 6, elapsed: 0.312)
        FirebaseLog.shared.logFirebase(.fetch, collection: "menu")
        FirebaseLog.shared.logFirebase(.success, collection: "menu", count: 6, elapsed: 0.312)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Group {
                    MainTabView()
//                        .task {
//                            await ProductSeeder.seedMenu()
//                            await FeaturedSeeder.seedFeaturedProducts()
//                        }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .preferredColorScheme(
                appTheme == 0 ? nil : (appTheme == 1 ? .light : .dark)
            )
            .withToast()
            .withLoading()
        }
    }
}

