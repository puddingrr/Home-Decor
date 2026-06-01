//
//  CartView.swift
//  Home Decor
//
//  Created by Dalynn on 12/15/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel
    @EnvironmentObject var orderVM: OrderViewModel

    @State private var isOrdering: Bool = false
    @State private var navigateToSummary: Bool = false
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(title: "My Cart", isBack: false, isShadow: true)
            RoundedRectangle(cornerRadius: 0)
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.3))
            
            if !cartVM.cartItems.isEmpty {
                ZStack {
                    VStack {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 12) {
                                ForEach(cartVM.cartItems) { item in
                                    HStack(alignment: .top, spacing: 10) {
                                        if let image = item.image {
                                            WebImage(url: URL(string: image))
                                                .resizable()
                                                .frame(width: 90, height: 90)
                                                .cornerRadius(10)
                                                .overlay {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                                }
                                        }
                                        
                                        VStack(alignment: .leading, spacing: 6) {
                                            TextSwifUI(title: item.title ?? "", size: .other(18), weight: .bold)
                                            TextSwifUI(title: "$\(item.price ?? "")", size: .other(16), color: .red, weight: .bold)
                                            Spacer(minLength: 0)
                                            HStack(spacing: 8) {
                                                Button { decreaseItem(item) } label: {
                                                    Image(.dicrease).resizable().frame(width: 24, height: 24)
                                                }
                                                TextSwifUI(title: "\(item.quantity ?? 1)", weight: .bold)
                                                Button { increaseItem(item) } label: {
                                                    Image(.increase).resizable().frame(width: 24, height: 24)
                                                }
                                            }
                                        }
                                        Spacer()
                                    }
                                    .padding(12)
                                    .frame(maxWidth: .infinity)
                                    .background(.authTitle)
                                    .cornerRadius(10)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.authBg.opacity(0.1), lineWidth: 1)
                                    }
                                }
                            }
                            .padding(16)
                        }
                        Spacer()
                        CustomSubmitOrderView(total: totalPrice, totalKHR: totalPrice * 4100, saved: savedAmount,
                                              onOrder: { handlePlaceOrder() }
                        )
                        .disabled(isOrdering)
                        .padding(.vertical, 12)
                    }
                    if  isOrdering {
                        ProgressView()
                            .tint(.white)
                            .padding()
                            .background(Color.black.opacity(0.3))
                            .cornerRadius(10)
                    }
                }
            } else {
                NoDataView()
            }
        }
        .navigationDestination(isPresented: $navigateToSummary) {
            OrderSummrayView()
                .environmentObject(cartVM)
                .environmentObject(orderVM)
        }
        .alert("Order Failed", isPresented: $showErrorAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(errorMessage)
        }
    }
    
    private func handlePlaceOrder() {
        isOrdering = true
        Task {
            await orderVM.placeOrder(
                items: cartVM.cartItems,
                totalUSD: totalPrice,
                totalKHR: totalPrice * 4100,
                savedAmount: savedAmount,
                onSuccess: {
//                    cartVM.clearCart()
                    isOrdering = false
                    navigateToSummary = true
                },
                onFailure: { message in
                    isOrdering = false
                    errorMessage = message
                    showErrorAlert = true
                }
            )
        }
    }
}

// MARK: - Computed Properties
extension CartView {
    private func increaseItem(_ item: ListMenu) {
        guard let index = cartVM.cartItems.firstIndex(where: { $0.id == item.id }) else { return }
        let currentQty = cartVM.cartItems[index].quantity ?? 1
        cartVM.cartItems[index].quantity = currentQty + 1
    }
    private func decreaseItem(_ item: ListMenu) {
        guard let index = cartVM.cartItems.firstIndex(where: { $0.id == item.id }) else { return }
        let currentQty = cartVM.cartItems[index].quantity ?? 1
        if currentQty > 1 {
            cartVM.cartItems[index].quantity = currentQty - 1
        } else {
            cartVM.removeFromCart(cartVM.cartItems[index])
        }
    }
    var totalPrice: Double {
        cartVM.cartItems.reduce(0) { result, item in
            let price = Double(item.price ?? "0") ?? 0
            let qty = item.quantity ?? 1
            return result + (price * Double(qty))
        }
    }
    var savedAmount: Double {
        totalPrice * 0.1
    }
    var finalTotal: Double {
        totalPrice - savedAmount
    }
}
struct NoDataView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(.cartEmpty)
                .resizable()
                .frame(width: 200, height: 200)
            TextSwifUI(title: "There are no items in your cart", size: .other(16), weight: .bold)
            Spacer()
        }
    }
}
// MARK: - Cart Bottom Bar
struct CartBottomBar: View {
    let isEmpty: Bool
    let subtotal: Double
    let khrRate: Double = 4027.0
    let onOrder: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 40, height: 40)
                Image(systemName: "bicycle")
                    .foregroundColor(isEmpty ? .gray : .yellow)
            }

            if isEmpty {
                Text("No items.")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("$1.50")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    Text("to send")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }
            } else {
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text("Subtotal:")
                            .foregroundColor(.white.opacity(0.7))
                        Text(String(format: "$%.2f", subtotal))
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                        Text("₭\(String(format: "%.2f", subtotal * khrRate))")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
                Button(action: onOrder) {
                    Text("Order")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color(hex: "#E8394A"))
                        .clipShape(Capsule())
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(Color(hex: "#1E2435"))
        .clipShape(Capsule())
        .padding(.horizontal, 16)
    }
}
