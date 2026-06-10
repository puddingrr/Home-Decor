//
//  CustomLoading.swift
//  Home Decor
//
//  Created by Dalynn on 6/2/26.
//
 import SwiftUI

class LoadingManager: ObservableObject {
    static let shared = LoadingManager()

    @Published var isLoading = false

    private init() {}

    func show() {
        DispatchQueue.main.async {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                self.isLoading = true
            }
        }
    }

    func hide() {
        DispatchQueue.main.async {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                self.isLoading = false
            }
        }
    }
}

struct LoadingView: View {
    @State private var rotate = false
    @State private var pulse = false
    var body: some View {
        ZStack {
            ProgressView()
                .progressViewStyle(.circular)
                .scaleEffect(1.4)
                .tint(.authBg)
                .padding(24)
                .background(.authTitle.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.black.opacity(0.15), lineWidth: 1))
        }
        .ignoresSafeArea()
    }
}

struct LoadingModifier: ViewModifier {
    @ObservedObject var manager = LoadingManager.shared

    func body(content: Content) -> some View {
        ZStack {
            content
            if manager.isLoading {
                LoadingView()
                    .transition(.scale(scale: 0.85).combined(with: .opacity))
                    .zIndex(999)
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.75), value: manager.isLoading)
    }
}

extension View {
    func withLoading() -> some View {
        modifier(LoadingModifier())
    }
}
