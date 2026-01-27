//
//  UINavigationController.swift
//  KKDollar-iOS
//
//  Created by Bhadresh on 18/10/23.
//

import SwiftUI
import UIKit

extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

    // To make it works also with ScrollView
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
}

struct NavigationControllerAccessor: UIViewControllerRepresentable {
    var callback: (UINavigationController?) -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        DispatchQueue.main.async {
            self.callback(viewController.navigationController)
        }
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
}

extension View {
    func disableSwipeBack(shouldDisable: Bool) -> some View {
        self.background(SwipeBackControlView(shouldDisable: shouldDisable))
    }
}

struct SwipeBackControlView: UIViewControllerRepresentable {
    let shouldDisable: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        DispatchQueue.main.async {
            updateSwipeGesture(for: controller)
        }
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        DispatchQueue.main.async {
            updateSwipeGesture(for: uiViewController)
        }
    }

    private func updateSwipeGesture(for viewController: UIViewController) {
        guard let navController = viewController.findNavigationController(),
              let popGesture = navController.interactivePopGestureRecognizer else { return }
        
        popGesture.isEnabled = !shouldDisable
        // Optional: Also disable gesture recognizer's delegate for extra strictness
        if shouldDisable {
            popGesture.delegate = nil
        }
    }
}

extension UIViewController {
    func findNavigationController() -> UINavigationController? {
        var responder: UIResponder? = self
        while let current = responder {
            if let nav = current as? UINavigationController {
                return nav
            }
            responder = current.next
        }
        return nil
    }
}
