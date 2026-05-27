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
    @AppStorage("appTheme") private var appTheme = 0
    
    init() {
        LogWriter.shared.log("App launched")
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Group {
                    MainTabView()
//                        .task {
//                            await ProductSeeder.seedMenu()
//                        }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .preferredColorScheme(
                appTheme == 0 ? nil : (appTheme == 1 ? .light : .dark)
            )
        }
    }
}

