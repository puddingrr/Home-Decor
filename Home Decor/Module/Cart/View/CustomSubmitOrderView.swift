//
//  OrderSummaryBarView.swift
//  Home Decor
//
//  Created by Dalynn on 5/28/26.
//

import SwiftUI

struct CustomSubmitOrderView: View {
    let total: Double
    let totalKHR: Double
    let saved: Double
    let onOrder: () -> Void

    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                HStack(alignment: .firstTextBaseline, spacing: 6) {
                    Text(String(format: "Total: $%.2f", total))
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    Text("៛\(String(format: "%.2f", totalKHR))")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
                Text(String(format: "Saved $%.2f", saved))
                    .font(.system(size: 12))
                    .foregroundColor(Color.yellow)
            }
            Spacer()
            Button(action: onOrder) {
                Text("Order")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 28)
                    .padding(.vertical, 12)
                    .background(Color(hex: "#E8394A"))
                    .clipShape(Capsule())
            }
        }
        .padding(.leading, 16).padding(.trailing, 6).padding(.vertical, 6)
        .background(Color(hex: "#1E2435"))
        .clipShape(Capsule())
        .padding(.horizontal, 16)
    }
}
