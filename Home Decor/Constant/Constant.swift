//
//  Constant.swift
//  Home Decor
//
//  Created by Dalynn on 12/3/25.
//

import Foundation
import SwiftUI
import DeviceKit

let minLimitPassowrd = 6
let maxLimitPassowrd = 16
let maxLimitOtp = 6
let maxLimitName = 45
let minLimitNickname = 1
let maxLimitNickname = 16
let minLimitPhoneNo = 4
let maxLimitPhoneNo = 16
let maxLimitEmail = 64
let countDownTime = 60
let maxFeedBackContent = 200

enum FontSize {
    case small
    case normal
    case medium
    case large
    case huge
    case other(CGFloat)

    var fontSize: CGFloat {
        switch self {
        case .small:
            return 12
        case .normal:
            return 14
        case .medium:
            return 16
        case .large:
            return 18
        case .huge:
            return 20
        case .other(let customSize):
            return customSize
        }
    }
}
enum FontName {
    case regular
    case thin
    case light
    case extraLight
    case medium
    case semiBold
    case bold
    case extraBold
    case black
    case other(String)
    
    var name: String {
        switch self {
        case .regular:
            return "Lexend-Regular"
        case .thin:
            return "Lexend-Thin"
        case .extraLight:
            return "Lexend-ExtraLight"
        case .light:
            return "Lexend-Light"
        case .medium:
            return "Lexend-Medium"
        case .semiBold:
            return "Lexend-SemiBold"
        case .bold:
            return "Lexend-Bold"
        case .extraBold:
            return "Lexend-ExtraBold"
        case .black:
            return "Lexend-Black"
        default:
            return "Lexend-Regular"
        }
    }
}

struct Constant {
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let appBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    static let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String
    static let bundleId: String = Bundle.main.bundleIdentifier ?? ""
    static let bundleIdkey: String = Bundle.main.bundleIdentifier?.replacing(".", with: "") ?? ""
    static let minPassword = 6
    static let maxPassword = 16
    
    static var env: String {
        #if Dev
            return "DEV"
        #elseif UAT
            return "UAT"
        #elseif SIT
            return "SIT"
        #else
            return ""
        #endif
    }
    
    static var googleService: String {
        #if Dev
            return "Dev-GoogleService-Info"
        #elseif UAT
            return "Dev-GoogleService-Info"
        #elseif SIT
            return "Dev-GoogleService-Info"
        #else
            return "GoogleService-Info"
        #endif
    }
}

enum AppEnvironment {
    case dev
    case sit
    case uat
    case production

    #if Dev
    static let current: AppEnvironment = .dev
    #elseif SIT
    static let current: AppEnvironment = .sit
    #elseif UAT
    static let current: AppEnvironment = .uat
    #else
    static let current: AppEnvironment = .production
    #endif

    static let logEnableEnvironments: [AppEnvironment] =  [.dev, .sit, .uat]

    /// Human-readable name for printing
    var description: String {
        switch self {
        case .dev: return "Development"
        case .sit: return "SIT"
        case .uat: return "UAT"
        case .production: return "Production"
        }
    }

    /// All environment-specific configuration in one place
    var config: EnvironmentConfig {
        switch self {
        case .dev:
            return EnvironmentConfig(
                merchantCode: "M54452",
                baseUrl: "https://gateway-game-dev.kkr88819.com",
                domain: "https://web-dev.kkr88819.com",
                googleService: "GoogleService-Info_K8_Dev"
            )
        case .sit:
            return EnvironmentConfig(
                merchantCode: "M34794",
                baseUrl: "https://test-gateway.kkr88819.com",
                domain: "https://test-h5.kkr88819.com",
                googleService: "GoogleService-Info_K8_Sit"
            )
        case .uat:
            return EnvironmentConfig(
                merchantCode: "M21353",
                baseUrl: "https://uat-gateway.kkr88819.com",
                domain: "https://uat-h5.kkr88819.com",
                googleService: "GoogleService-Info_K8_Uat"
            )
        case .production:
            return EnvironmentConfig(
                merchantCode: "M21353",
                baseUrl: "https://k8newaaap.com",
                domain: "https://k8newaaap.com",
                googleService: "GoogleService-Info"
            )
        }
    }
}

/// Holds all environment-specific values together
struct EnvironmentConfig {
    let merchantCode: String
    let baseUrl: String
    let domain: String
    let googleService: String
}
enum AppTheme: String {
    case system, light, dark
}
enum TextFieldType {
    case emailOrPhone
    case email
    case password
    case normal
    case mobileNo
    case otp
    case withTrailingButton
}

struct DictionaryEncoder {
    static func encode<T: Codable>(_ value: T) throws -> [String: Any] {
        let data = try JSONEncoder().encode(value)
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
    }
}

struct DictionaryDecoder {
    static func decode<T: Codable>(_ type: T.Type, from dict: [String: Any]) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: dict, options: [])
        return try JSONDecoder().decode(T.self, from: data)
    }
}

struct AppInfo {
    static var displayName: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
        Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? "Unknown"
    }
    
    static var bundleIdentifier: String {
        Bundle.main.bundleIdentifier ?? "Unknown"
    }
    
    static var version: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown"
    }
    
    static var build: String {
        Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unknown"
    }
    
    static var gitBranch: String {
        Bundle.main.object(forInfoDictionaryKey: "GIT_BRANCH") as? String ?? "Unknown"
    }
}

struct DeviceInfo {
    static var osVersion: String { UIDevice.current.systemVersion }
    static var model: String { UIDevice.current.model }
    static var name = Device.current.description
}

struct AppInfoLogger {
//    static func log(_ env: AppEnvironment) {
    static func log() {
        // Git branch (only works if you set it at build time)
        print("""
        ============================================================
        ================= 📱 App Info=================
        📝 Display Name        : \(AppInfo.displayName)
        📦 Version             : \(AppInfo.version)
        🏗️ Build               : \(AppInfo.build)
        📦 Bundle Identifier   : \(AppInfo.bundleIdentifier)
        🌿 gitBranch           : \(AppInfo.gitBranch)

        ================= 🔧 Environment Details =================
        🌍 Current Environment : \("")
        🏦 Merchant Code       : \("")
        🔗 Base URL            : \("")

        ================= 📱 Device Info =================
        Device Token           : \(ConfigurationDataManager.shared.deviceToken)
        Device ID              : \(Utilize.shared.getDataKeychain(for: Constant.bundleIdkey) ?? "")
        Device Model           : \(DeviceInfo.model)
        Device Name            : \(DeviceInfo.name)
        iOS Version            : \(DeviceInfo.osVersion)
        ===================================================\n
        """)
    }
}
