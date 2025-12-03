//
//  Utiize.swift
//  Home Decor
//
//  Created by Dalynn on 8/26/25.
//
import Foundation
import SwiftUI

public class Utilize {
    
    static let shared = Utilize()
    
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

