//
//  Constant.swift
//  Home Decor
//
//  Created by Dalynn on 12/3/25.
//

import Foundation
import SwiftUI

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

class Constant {
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

enum TextFieldType {
    case emailOrPhone
    case email
    case password
    case normal
    case mobileNo
    case otp
    case withTrailingButton
}
