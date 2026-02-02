//
//  ProfileButton.swift
//  LMS-iOS
//
//  Created by Sok Pich on 2/12/25.
//

import SwiftUI

struct Profilebutton: View {
    var buttonImage: ImageResource
    var buttonTitle: String
    var hideNavigateButton: Bool = false
    var action: (() -> Void)?
    @State private var selectedlanguage: String = ""
    
    @AppStorage("enableBioMetric") var enableBioMetric: Bool = false
    
    var body: some View {
        VStack {
                HStack {
                    Image(buttonImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    TextSwifUI(title: buttonTitle, color: buttonTitle == "logout" ? .red : .commonText)
                    Spacer()
                    if buttonTitle == "language" {
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
