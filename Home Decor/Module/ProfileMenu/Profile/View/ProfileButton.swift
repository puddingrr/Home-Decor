//
//  ProfileButton.swift
//  LMS-iOS
//
//  Created by Sok Pich on 2/12/25.
//

import SwiftUI

struct Profilebutton: View {
    var buttonImage: String
    var buttonTitle: String
    var hideNavigateButton: Bool = false
    var action: (() -> Void)?
    @State private var selectedlanguage: String = ""
        
    var body: some View {
        VStack {
                HStack {
                    Image(systemName: buttonImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    TextSwifUI(title: buttonTitle, color: buttonTitle == "Logout" ? .red : .commonText, weight: buttonTitle == "Logout" ? .bold: .regular)
                    Spacer()
                    if buttonTitle == "Language" {
                        TextSwifUI(title: selectedlanguage, size: .small, weight: .light)
                    }
                    
                    if !hideNavigateButton {
                        Image(.arrowRight)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 8, height: 14)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
                .contentShape(Rectangle())
                .onTapGesture {
                    action?()
                }
        }
    }
}
