//
//  EditProfile.swift
//  Home Decor
//
//  Created by Dalynn on 8/28/25.
//

import SwiftUI

struct EditProfileView: View {
    @StateObject var viewModel: ProfileViewModel
    var body: some View {
        VStack {
            CustomNavBar(title: "My Profile", tinhColor: .main)
            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 100)
                        .overlay {
                            Image(.myprofile)
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    VStack {
                        TextSwifUI(title: "Madison Smith", size: 20, weight: .bold)
                        TextSwifUI(title: "ID: 25030024", size: 13)
                    }
                    .padding(.vertical, 16)
                    .frame(maxWidth: .infinity)
                    .background(Color.lightOrange)
                }
                
                VStack(alignment: .leading) {
                    ForEach(viewModel.listTextField.indices, id: \.self) { i in
                        CustomTextField(title: viewModel.listTextField[i].title, textValue: $viewModel.inputText)
                    }
                    .padding(.top, 8)
                    
                    TextSwifUI(title: "Gender")
                        .padding(.top, 8)
                    
                    HStack {
                        HStack {
                            Image(.nonSelected)
                                .resizable()
                                .frame(width: 15, height: 15)
                            TextSwifUI(title: "Male")
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(Color.lightOrange.cornerRadius(14))
                        HStack {
                            Image(.isSelected)
                                .resizable()
                                .frame(width: 15, height: 15)
                            TextSwifUI(title: "Female")
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity)
                        .background(Color.lightOrange.cornerRadius(14))
                    }
                }
                .padding(16)
                TextSwifUI(title: "Update Profile", size: 16, color: .selectPink, weight: .semibold)
                    .padding(.horizontal, 16)
                    .frame(height: 35)
                    .background(Color.main.cornerRadius(14))
            }
            Spacer()
        }
    }
    @ViewBuilder
    func textfield(title: String, text: String) -> some View {
        
    }
}

struct TextfieldList {
    let title, subTittle: String
}
