//
//  ProfileSectionView.swift
//  LMS-iOS
//
//  Created by Sok Pich on 2/12/25.
//

import SwiftUI

struct ProfileSectionView: View {
    let title: String?
    let items: [ItemModel]
    @Binding var isNavigated: Bool
    @Binding var selectedButton: String
    var logoutAction: (() -> Void)?
    
    var body: some View {
        VStack {
            if let title = title {
                CustomLabelView(leadingText: title, leadingWeight: .medium)
            }
            VStack(spacing: 0) {
                ForEach(items.indices, id: \.self) { index in
                    let item = items[index]
                    let isLastItem = index == items.count - 1
                    
                    Profilebutton(
                        buttonImage: item.image,
                        buttonTitle: item.title
                    ) {
                        if item.title == "Logout" {
                            showLogoutAlert()
                        } else {
                            isNavigated = true
                            selectedButton = item.title
                        }
                    }
                    
                    if !isLastItem {
                        Divider()
                            .padding(.horizontal, 22)
                    }
                }
            }
            .background(Color.darkCardBG)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
            )
        }
    }
    
    func showLogoutAlert() {
        Utilize.shared.showAlertWithButton(
            title: "Logout",
            message: "Are you sure you want to logout?",
            yesTitle: "Logout",
            noTitle: "Cancel"
        ) { selectedOption in
            if selectedOption == 1 {
                logoutAction?()
            }
        }
    }
}
