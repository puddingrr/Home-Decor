//
//  CustomToast.swift
//  Home Decor
//
//  Created by Dalynn on 6/1/26.
//
import SwiftUI
//
//  CustomToast.swift
//  Home Decor
//
//  Created by Dalynn on 6/1/26.
//

import SwiftUI

// MARK: - Toast Type

enum ToastType {
    case success, error, warning, info

    var icon: String {
        switch self {
        case .success: return "checkmark"
        case .error:   return "xmark"
        case .warning: return "exclamationmark"
        case .info:    return "info"
        }
    }

    var color: Color {
        switch self {
        case .success: return Color(hex: "#3b6d11")
        case .error:   return Color(hex: "#a32d2d")
        case .warning: return Color(hex: "#854f0b")
        case .info:    return Color(hex: "#185fa5")
        }
    }

    var bgColor: Color {
        switch self {
        case .success: return Color(hex: "#eaf3de")
        case .error:   return Color(hex: "#fcebeb")
        case .warning: return Color(hex: "#faeeda")
        case .info:    return Color(hex: "#e6f1fb")
        }
    }
}

struct ToastModel: Equatable {
    let type: ToastType
    let title: String
    let message: String

    static func == (lhs: ToastModel, rhs: ToastModel) -> Bool {
        lhs.title == rhs.title && lhs.message == rhs.message
    }
}

struct ToastView: View {
    let toast: ToastModel
    let onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 12) {

            Circle()
                .fill(toast.type.color.opacity(0.12))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: toast.type.icon)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(toast.type.color)
                )
            toast.type.color
                .frame(height: 1)
                .padding(.horizontal, 20)
                .padding(.top, 8)
            Text(toast.title)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(toast.type.color)
                .multilineTextAlignment(.center)
                .padding(.top, 8)

            if !toast.message.isEmpty {
                Text(toast.message)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
            }
        }
        .padding(20)
        .frame(width: 300, height: 200)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: toast.type.color.opacity(0.15), radius: 20, x: 0, y: 8)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(toast.type.color.opacity(0.2), lineWidth: 1)
        )
        .padding(.horizontal, 40)
    }
}

class ToastManager: ObservableObject {
    static let shared = ToastManager()

    @Published var current: ToastModel? = nil
    private var dismissTask: Task<Void, Never>?

    private init() {}

    func showPositive(title: String = "Success", message: String = "") {
        show(ToastModel(type: .success, title: title, message: message))
    }

    func showNegative(title: String = "Error", message: String = "") {
        show(ToastModel(type: .error, title: title, message: message))
    }

    func showWarning(title: String = "Warning", message: String = "") {
        show(ToastModel(type: .warning, title: title, message: message))
    }

    func showInfo(title: String = "Info", message: String = "") {
        show(ToastModel(type: .info, title: title, message: message))
    }

    private func show(_ toast: ToastModel) {
        dismissTask?.cancel()
        withAnimation(.spring(response: 0.38, dampingFraction: 0.75)) {
            current = toast
        }
        dismissTask = Task {
            try? await Task.sleep(nanoseconds: 3_000_000_000)
            guard !Task.isCancelled else { return }
            await MainActor.run { dismiss() }
        }
    }

    func dismiss() {
        dismissTask?.cancel()
        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
            current = nil
        }
    }
}

struct ToastModifier: ViewModifier {
    @ObservedObject var manager = ToastManager.shared

    func body(content: Content) -> some View {
        ZStack {
            content

            if let toast = manager.current {
                Color.black.opacity(0.15)
                    .ignoresSafeArea()
                    .onTapGesture { manager.dismiss() }
                    .transition(.opacity)
                    .zIndex(998)

                ToastView(toast: toast) {
                    manager.dismiss()
                }
                .transition(
                    .asymmetric(
                        insertion: .scale(scale: 0.8).combined(with: .opacity),
                        removal:   .scale(scale: 0.8).combined(with: .opacity)
                    )
                )
                .zIndex(999)
            }
        }
        .animation(.spring(response: 0.38, dampingFraction: 0.75), value: manager.current)
    }
}

extension View {
    func withToast() -> some View {
        modifier(ToastModifier())
    }
}
