//
//  SubmitOrderView.swift
//  Home Decor
//
//  Created by Dalynn on 5/28/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderSummrayView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var orderVM: OrderViewModel

    let khrRate: Double = 4027.0
    let deliveryFee: Double = 0.55
    let deliveryOriginal: Double = 0.75

    var subtotal: Double {
        cartVM.cartItems.reduce(0) { result, item in
            let price = Double(item.price ?? "0") ?? 0
            let qty = Double(item.quantity ?? 1)
            return result + (price * qty)
        }
    }
    var total: Double { subtotal + deliveryFee }
    var saved: Double { subtotal * 0.1 }

    @State private var isNavSelectedAdress: Bool = false
    @State private var isSheetDiliveryTime: Bool = false
    @State private var isOrdering: Bool = false
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage: String = ""
    @State private var navigateToOrderSuccess: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(title: "Submit order", isBack: true, isbackhColor: .red, isShadow: true)
                .background(Color(.systemBackground))
            Divider()
            ZStack {
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            AddressSection() {
                                isNavSelectedAdress = true
                            }
                            Divider().padding(.leading, 20)
                            InfoRow(label: "Delivery time", value: "ASAP") {
                                isSheetDiliveryTime.toggle()
                            }
                            Divider().padding(.leading, 20)
                            InfoRow(label: "Payment method", value: "Cash On Delivery")
                            
                            Rectangle()
                                .fill(Color(.systemGroupedBackground))
                                .frame(height: 8)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                HStack(spacing: 8) {
                                    Image(systemName: "bag")
                                        .font(.system(size: 15))
                                        .foregroundColor(.secondary)
                                    Text("Home Decore")
                                        .font(.system(size: 16, weight: .semibold))
                                }
                                .padding(.horizontal, 20)
                                .padding(.top, 14)
                                .padding(.bottom, 10)
                                
                                Divider()
                                
                                ForEach(cartVM.cartItems) { item in
                                    OrderItemRow(item: item)
                                    Divider().padding(.leading, 20)
                                }
                                
                                SubtotalRow(subtotal: subtotal, khrRate: khrRate)
                            }
                            
                            Rectangle()
                                .fill(Color(.systemGroupedBackground))
                                .frame(height: 8)
                            
                            DeliveryFeeSection(original: deliveryOriginal, discounted: deliveryFee)
                            
                            Rectangle()
                                .fill(Color(.systemGroupedBackground))
                                .frame(height: 8)
                            
                            VStack(spacing: 0) {
                                CouponRow(label: "Coupon", hasHelp: true, value: "No coupon available")
                                Divider().padding(.leading, 20)
                                CouponRow(label: "Delivery fee coupon", hasHelp: false, value: "No delivery fee coupon available")
                                Divider().padding(.leading, 20)
                                CouponRow(label: "Promo code", hasHelp: true, value: "Use promo code", valueColor: .red)
                            }
                            
                            Rectangle()
                                .fill(Color(.systemGroupedBackground))
                                .frame(height: 8)
                            
                            HStack {
                                Text("Discount")
                                    .font(.system(size: 15, weight: .semibold))
                                Spacer()
                                Text("-$0.00")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.red)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            
                            Rectangle()
                                .fill(Color(.systemGroupedBackground))
                                .frame(height: 8)
                            
                            HStack {
                                Text("Note")
                                    .font(.system(size: 15))
                                    .foregroundColor(.primary)
                                Spacer()
                                Text("Your requirements (Taste, like)")
                                    .font(.system(size: 14))
                                    .foregroundColor(.secondary)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 12))
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 14)
                            
                            Spacer().frame(height: 90)
                        }
                    }
                    
                    OrderBottomBar(total: total, totalKHR: total * khrRate, saved: saved) {
                        handlePlaceOrder()
                    } 
                }
            }
        }
        .navigationBarHidden(true)
        .background(Color(.systemBackground))
        .navigationDestination(isPresented: $isNavSelectedAdress) {
            ChooseAddressView()
        }
        .navigationDestination(isPresented: $navigateToOrderSuccess) {
            OrderView()
                .environmentObject(orderVM)
        }
        .bottomSheet(
            isPresented: $isSheetDiliveryTime,
            detents: [.fixed(140)],
            shouldScrollExpandSheet: true,
            cornerRadius: 25,
            showNavigationBar: false
        ) {
            VStack(spacing: 8) {
                HStack {
                    TextSwifUI(title: "Choose delivery time")
                    Spacer()
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .onTapGesture { isSheetDiliveryTime = false }
                }
                .padding(.top, 12)
                Divider()
                HStack {
                    TextSwifUI(title: "Today", color: .gray)
                    Spacer()
                    TextSwifUI(title: "Now", color: .red)
                }
                .padding(.vertical, 12)
                Spacer()
            }
            .padding(16)
        }
    }

    private func handlePlaceOrder() {
        guard !isOrdering else { return }
        isOrdering = true
        LoadingManager.shared.show()
        Task {
            await orderVM.placeOrder(
                items: cartVM.cartItems,
                totalUSD: total,
                totalKHR: total * khrRate,
                savedAmount: saved,
                onSuccess: {
                    cartVM.clearCart()
                    LoadingManager.shared.hide()
                    navigateToOrderSuccess = true
                    isOrdering = false
                },
                onFailure: { message in
                    LoadingManager.shared.hide()
                    errorMessage = message
                    showErrorAlert = true
                    isOrdering = false
                }
            )
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String
    var action: (() -> Void)?

    var body: some View {
        HStack {
            Text(label)
                .font(.system(size: 15))
                .foregroundColor(.primary)
            Spacer()
            Button {
                action?()
            } label: {
                Text(value)
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color(.systemBackground))
    }
}
struct OrderItemRow: View {
    let item: ListMenu
    var originalPrice: Double { (Double(item.price ?? "0") ?? 0) * 1.3 }
    var discountedPrice: Double { Double(item.price ?? "0") ?? 0 }

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            if let imageUrl = item.image {
                WebImage(url: URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 72, height: 72)
                    .cornerRadius(8)
                    .clipped()
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title ?? "")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.primary)
                Text("pcs")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)

                Spacer(minLength: 0)

                HStack {
                    Text("x\(item.quantity ?? 1)")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(String(format: "$%.2f", originalPrice))
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .strikethrough(true, color: .secondary)
                    Text(String(format: "$%.2f", discountedPrice))
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
    }
}

struct SubtotalRow: View {
    let subtotal: Double
    let khrRate: Double
    var originalSubtotal: Double { subtotal * 1.3 }

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Subtotal")
                .font(.system(size: 15, weight: .semibold))
            Spacer()
            VStack(alignment: .trailing, spacing: 3) {
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(String(format: "$%.2f", originalSubtotal))
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .strikethrough(true, color: .secondary)
                    Text(String(format: "$%.2f", subtotal))
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.primary)
                }
                HStack(spacing: 2) {
                    Text("1USD=\(String(format: "%.2f", khrRate))KHR")
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)
                    Text("៛\(String(format: "%.2f", subtotal * khrRate))")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.primary)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color(.systemBackground))
    }
}
struct DeliveryFeeSection: View {
    let original: Double
    let discounted: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 6) {
                Text("Delivery Fee")
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                ZStack {
                    Circle()
                        .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
                        .frame(width: 16, height: 16)
                    Text("?")
                        .font(.system(size: 10))
                        .foregroundColor(.secondary)
                }
            }

            Text("Promotion deduct $0.20 delivery fee")
                .font(.system(size: 13))
                .foregroundColor(.secondary)

            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text("Standard")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.primary)
                        Text("· 30 minutes")
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                HStack(spacing: 6) {
                    Text(String(format: "$%.2f", original))
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                        .strikethrough(true, color: .secondary)
                    Text(String(format: "$%.2f", discounted))
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.primary)
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.red, lineWidth: 1.5)
            )
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color(.systemBackground))
    }
}
struct CouponRow: View {
    let label: String
    let hasHelp: Bool
    let value: String
    var valueColor: Color = .secondary
    var action: (() -> Void)?

    var body: some View {
        HStack {
            HStack(spacing: 6) {
                Text(label)
                    .font(.system(size: 15))
                    .foregroundColor(.primary)
                if hasHelp {
                    ZStack {
                        Circle()
                            .stroke(Color.secondary.opacity(0.5), lineWidth: 1)
                            .frame(width: 16, height: 16)
                        Text("?")
                            .font(.system(size: 10))
                            .foregroundColor(.secondary)
                    }
                }
            }
            Spacer()
            Button {
                action?()
            } label: {
                Text(value)
                    .font(.system(size: 13))
                    .foregroundColor(valueColor)
                Image(systemName: "chevron.right")
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 13)
        .background(Color(.systemBackground))
    }
}

struct OrderBottomBar: View {
    let total: Double
    let totalKHR: Double
    let saved: Double
    var isLoading: Bool = false
    let onOrder: () -> Void

    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text("Total:")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    Text(String(format: "$%.2f", total))
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                    Text("៛\(String(format: "%.2f", totalKHR))")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                Text("Saved \(String(format: "$%.2f", saved))")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(Color(hex: "#FFB800"))
            }

            Spacer()
            Button(action: onOrder) {
                ZStack {
                    Text("Order")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 120, height: 50)
                }
                .background(Color(hex: "#E8394A"))
                .clipShape(Capsule())
            }
            .disabled(isLoading)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(Color(hex: "#1C1C1E"))
    }
}
