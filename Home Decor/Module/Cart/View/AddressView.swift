//
//  AdressView.swift
//  Home Decor
//
//  Created by Dalynn on 5/28/26.
//

import SwiftUI
struct AddressView: View {
    var body: some View {
        VStack {
            
        }
    }
}
struct AddressSection: View {
    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.red.opacity(0.1))
                    .frame(width: 48, height: 48)
                Image(systemName: "camera")
                    .font(.system(size: 18))
                    .foregroundColor(.red.opacity(0.7))
            }

            VStack(alignment: .leading, spacing: 3) {
                Text("Khan Sensok Phnom Penh Phnom Penh Cambodia")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                Text("Dalyn, 855069680104")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 14)
        .background(Color(.systemBackground))
    }
}
