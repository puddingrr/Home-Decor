//
//  UserPreference.swift
//  InfoWebiOS
//
//  Created by Brilliant Dev on 26/4/24.
//

import Foundation
import SwiftUI

class UserPreference {
    static let shared = UserPreference()
    private var defaults: UserDefaults = UserDefaults.standard
    
    private let setUserData = "setUserData"
    private let isDarkMode = "isDarkMode"
    
    private let loginKeyData = "LoginData"
    private let setToken = "setToken"
    private let appVersionKey = "app_version"
    
    func saveAppVersion(_ version: String) {
        defaults.set(version, forKey: appVersionKey)
    }
    func getAppVersion() -> String? {
        return defaults.object(forKey: appVersionKey) as? String
    }
    
    // MARK: Dark Mode
    func getIsDarkMode() -> Bool {
        guard let isDarkMode = defaults.object(forKey: isDarkMode) as? Bool else {
            if UIScreen.main.traitCollection.userInterfaceStyle == .dark {
                self.setIsDarkMode(set: true)
                return true
            } else {
                self.setIsDarkMode(set: false)
                return false
            }
        }
        return isDarkMode
    }
    
    func setIsDarkMode(set: Bool) {
        defaults.set(set, forKey: isDarkMode)
    }
    
    func getSystemLanguage() -> String {
        if let preferredLanguage = Locale.preferredLanguages.first {
            let components = Locale.Components(identifier: preferredLanguage)
            return components.languageComponents.languageCode?.identifier ?? ""
        }
        return ""
    }
    
    func saveLoginData(_ data: LoginDataModel) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(data) {
            defaults.set(encoded, forKey: loginKeyData)
        }
    }
     
     // Retrieve user data
    func getLoginData() -> LoginDataModel? {
        guard let savedData = defaults.data(forKey: loginKeyData) else {
            return nil
        }
        let decoder = JSONDecoder()
        return try? decoder.decode(LoginDataModel.self, from: savedData)
    }
     
     // Clear user data on logout
     func clearLoginData() {
         defaults.removeObject(forKey: loginKeyData)
     }
    
    func setToken(token: String) {
        defaults.set(token, forKey: setToken)
    }
    
    func getToken() -> String {
        return defaults.object(forKey: setToken) as? String ?? ""
    }
}
