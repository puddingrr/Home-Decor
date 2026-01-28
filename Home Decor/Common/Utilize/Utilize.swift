//
//  Utiize.swift
//  Home Decor
//
//  Created by Dalynn on 8/26/25.
//
import Foundation
import SwiftUI
import UIKit

public class Utilize {
    
    static let shared = Utilize()
    @AppStorage("isDarkMode") private var isDarkMode = UserPreference.shared.getIsDarkMode()
    private var isAlertPresented = false
    
    static func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func showAlert(title: String = "", message: String, ok: String = "Ok", action: (() -> Void)? = nil) {
        guard !isAlertPresented else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            if let topmostViewController = UIViewController.topMostViewController(),
               !topmostViewController.isBeingPresented, !topmostViewController.isBeingDismissed {
                if !(topmostViewController.presentedViewController is UIAlertController) {
                    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                    alert.overrideUserInterfaceStyle = self.isDarkMode ? .dark : .light
                    let button = UIAlertAction(title: "OK".uppercased(), style: .cancel) { [weak self] _ in
                        self?.isAlertPresented = false
                        action?()
                    }
                    alert.addAction(button)
                    topmostViewController.present(alert, animated: true) {
                        self.isAlertPresented = true
                    }
                }
            }
        }
    }
    
    func showAlertWithButton(title: String = "",
                             message: String,
                             titleFontSize: CGFloat = 16,
                             yesTitle: String = "Yes".uppercased(),
                             noTitle: String = "No".uppercased(),
                             action: ((Int) -> Void)? = nil) {
        Utilize.hideKeyboard()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        let attributedTitle = NSAttributedString(
                        string: title,
                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: titleFontSize, weight: .bold)]
                    )
                    alert.setValue(attributedTitle, forKey: "attributedTitle")
        let buttonNo = UIAlertAction(title: noTitle, style: .destructive) { _ in
            action?(0)
        }
        alert.addAction(buttonNo)
        
        let buttonYes = UIAlertAction(title: yesTitle, style: .default) { _ in
            action?(1)
        }
        alert.addAction(buttonYes)
        
        if let topmostViewController = UIViewController.topMostViewController(),
            !topmostViewController.isBeingPresented, !topmostViewController.isBeingDismissed {
            topmostViewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func saveDataKeychain(_ token: String, for account: String) -> Bool {
        guard let token = token.data(using: .utf8) else { return false }

        // First, delete any existing item
        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account
        ]
        SecItemDelete(deleteQuery as CFDictionary)

        // Now, save new item
        let saveQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: token
        ]

        let status = SecItemAdd(saveQuery as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    func getDataKeychain(for account: String) -> String? {
        let getQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: AnyObject?
        let status = SecItemCopyMatching(getQuery as CFDictionary, &item)

        guard status == errSecSuccess,
              let data = item as? Data,
              let password = String(data: data, encoding: .utf8)
        else {
            return nil
        }

        return password
    }
    
    func deleteDataKeychain(for account: String) -> Bool {
        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account
        ]

        let status = SecItemDelete(deleteQuery as CFDictionary)
        return status == errSecSuccess || status == errSecItemNotFound
    }
}

