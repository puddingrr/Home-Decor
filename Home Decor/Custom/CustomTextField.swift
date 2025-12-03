//
//  CustomTextField.swift
//  Home Decor
//
//  Created by Dalynn on 8/29/25.
//

import SwiftUI

struct CustomTextField: View {
    var title: String
    @Binding var textValue: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            TextSwifUI(title: title)
            
            HStack {
                TextField("Enter text", text: $textValue)
                    .frame(height: 40)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
            .background(Color.lightOrange.cornerRadius(14))
        }
    }
}
