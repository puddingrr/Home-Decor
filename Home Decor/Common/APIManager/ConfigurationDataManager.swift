//
//  Utiize.swift
//  Home Decor
//
//  Created by Dalynn on 8/26/25.
//

import Foundation
import SwiftUI

class ConfigurationDataManager: ObservableObject {
    static var shared = ConfigurationDataManager()
    var isLanguageKey: Bool = false
    var deviceToken: String = ""
}
