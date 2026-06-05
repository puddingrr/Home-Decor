//
//  OrderView.swift
//  Home Decor
//
//  Created by Dalynn on 6/1/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct OrderView: View {
    @EnvironmentObject var orderVM: OrderViewModel

    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(title: "My Orders", isBack: false, isShadow: true)
            RoundedRectangle(cornerRadius: 0)
                .frame(height: 1)
                .foregroundColor(Color.gray.opacity(0.3))

            if !orderVM.ordersList.isEmpty {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        ForEach(orderVM.ordersList) { order in
                            OrderCard(order: order)
                        }
                    }
                    .padding(16)
                }
                Spacer()
            } else {
                NoDataView()
            }
        }
    }
}

struct OrderCard: View {
    let order: OrderModel

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Order #\(order.id?.prefix(8) ?? "-")")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.primary)
                    Text(order.createdAt.formatted(date: .abbreviated, time: .shortened))
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
                Spacer()
                OrderStatusBadge(status: order.status)
            }

            Divider()

            ForEach(order.items) { item in
                HStack(alignment: .top, spacing: 10) {
                    if let image = item.image {
                        WebImage(url: URL(string: image))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 70, height: 70)
                            .cornerRadius(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            }
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        TextSwifUI(title: item.title ?? "", size: .other(15), weight: .bold)
                        TextSwifUI(title: "$\(item.price ?? "")", size: .other(13), color: .red, weight: .bold)
                        Text("Qty: \(item.quantity ?? 1)")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
            }

            Divider()

            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Total: $\(String(format: "%.2f", order.totalUSD))")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.primary)
                    Text("៛\(String(format: "%.0f", order.totalKHR))")
                        .font(.system(size: 11))
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text("Saved: $\(String(format: "%.2f", order.savedAmount))")
                    .font(.system(size: 11))
                    .foregroundColor(.green)
            }
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

// MARK: - Status Badge

struct OrderStatusBadge: View {
    let status: String

    var badgeColor: Color {
        switch status.lowercased() {
        case "success":    return .green
        case "pending":    return .orange
        case "confirmed":  return .blue
        case "delivered":  return .green
        case "cancelled":  return .red
        default:           return .gray
        }
    }

    var body: some View {
        Text(status.capitalized)
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(.white)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(badgeColor)
            .clipShape(Capsule())
    }
}
