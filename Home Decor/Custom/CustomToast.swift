//
//  CustomToast.swift
//  Home Decor
//
//  Created by Dalynn on 6/1/26.
//
import SwiftUI

enum ToastType {
    case success, error

    var icon: String {
        switch self {
        case .success: return "checkmark"
        case .error:   return "xmark"
        }
    }
    var color: Color {
        switch self {
        case .success: return .green
        case .error:   return .red
        }
    }
    var title: String {
        switch self {
        case .success: return "Added to Cart"
        case .error:   return "Already in Cart"
        }
    }
    var subtitle: String {
        switch self {
        case .success: return "Item added successfully"
        case .error:   return "This item is already in your cart."
        }
    }
}

struct ToastView: View {
    let type: ToastType
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.18)
                .ignoresSafeArea()
                .onTapGesture { withAnimation { isPresented = false } }

            VStack(spacing: 10) {
                Circle()
                    .fill(type.color.opacity(0.15))
                    .frame(width: 64, height: 64)
                    .overlay(
                        Image(systemName: type.icon)
                            .font(.system(size: 26, weight: .semibold))
                            .foregroundColor(type.color)
                    )

                Text(type.title)
                    .font(.system(size: 17, weight: .bold))

                Text(type.subtitle)
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(32)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .overlay(RoundedRectangle(cornerRadius: 22)
                .stroke(Color.black.opacity(0.07), lineWidth: 0.5))
            .padding(.horizontal, 48)
        }
    }
}
