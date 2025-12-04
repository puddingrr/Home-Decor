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

enum TextFieldType {
    case emailOrPhone
    case email
    case password
    case normal
    case mobileNo
    case otp
    case withTrailingButton
}
