//
//  ProfileView.swift
//  Home Decor
//
//  Created by Dalynn on 8/28/25.
//
import SwiftUI


struct ProfileView: View {
    @StateObject var profileVM = ProfileViewModel()
    @State var isNavigated: Bool = false
    @State var selectedButton: String = ""
    @EnvironmentObject var mainVM: MainViewModel

    var body: some View {
        VStack {
            CustomNavBar(title: "My Profile", tinhColor: .main, trailingBtnIcon: .edit, isBack: false, actionTrailingIcon: {
                profileVM.isSelectedEdit.toggle()
            })
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    VStack(spacing: 16) {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 100, height: 100)
                            .overlay {
                                Image(.myprofile)
                                    .resizable()
                                    .frame(width: 40, height: 40)
                            }
                        VStack {
                            TextSwifUI(title: "Madison Smith", size: .huge, weight: .bold)
                            TextSwifUI(title: "ID: 25030024", size: .small)
                        }
                        HStack {
                            menuCard(image: .myprofile, text: "Profile") {}
                            menuCard(image: .wishlistActive, text: "Wishlist") {}
                            menuCard(image: .myOrder, text: "My Orders", isLast: false) {
                                profileVM.isOrder.toggle()
                            }
                        }
                        .padding(.vertical, 12)
                        .cornerRadius(20)
                        .frame(height: 81)
                        .background(Color.main.cornerRadius(16))
                    }
                    //                VStack(alignment: .leading, spacing: 15) {
                    //                    ForEach(viewModel.listMenu.indices, id: \.self) { i in
                    //                        menuList(image: viewModel.listMenu[i].image, text: viewModel.listMenu[i].text) {
                    //                            viewModel.isSelected = i
                    //                        }
                    //                    }
                    //                }
                    //                .padding(.horizontal, 16)
                    ProfileSectionView(title: "Profile Info",
                                       items: profileVM.profileInfoList, isNavigated: $isNavigated, selectedButton: $selectedButton)
                    ProfileSectionView(title: "Seting", items: profileVM.otherList, isNavigated: $isNavigated, selectedButton: $selectedButton) {
                        profileVM.logout {
                            mainVM.tabIndex = 0
                        }
                    }
                    let lougout = "\(Constant.env) \("version") \(Constant.appVersion ?? "")(\(Constant.appBuildNumber ?? ""))"
                    TextSwifUI(title: lougout, size: .small, weight: .light)
                }
                Spacer()
            }
            .padding(16)
        }
        .navigationDestination(isPresented: $profileVM.isOrder) {
            MyOrderView(viewModel: profileVM)
        }
        .navigationDestination(isPresented: $profileVM.isSelectedEdit) {
            EditProfileView(viewModel: profileVM)
        }
    }
    
//    func getButtonNavigationType(for selectedButton: String) -> ButtonNavigationType? {
//        switch selectedButton {
//        case "Privacy Policy":
//            return .privacyPolicy
//        default:
//            return nil
//        }
//    }
    
    
    @ViewBuilder
    func menuCard(image: ImageResource, text: String, isLast: Bool = true, action: (()-> Void)?) -> some View {
        Button {
            action?()
        } label: {
            VStack(spacing: 8) {
                Image(image)
                    .resizable()
                    .frame(width: 26, height: 26)
                TextSwifUI(title: text, size: .small, weight: .regular)
            }
            .frame(maxWidth: .infinity)
        }
        if isLast {
            Divider()
                .frame(width: 1)
                .background(Color.white)
        }
    }
    @ViewBuilder
    func menuList(image: ImageResource, text: String, isLast: Bool = false, action: (() -> Void)?) -> some View {
        VStack {
            HStack(spacing: 16) {
                ZStack {
                    Circle()
                        .fill(Color.main)
                        .frame(width: 34, height: 34)
                        .overlay {
                            Image(image)
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                }
                TextSwifUI(title: text, size: .large)
                Spacer()
            }
            if isLast {
                Divider()
            }
        }
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            action?()
        }
    }
}

struct MenuList {
    let image: ImageResource
    let text: String
}

struct ItemModel {
    let image: ImageResource
    let title: String
    var secondTitle: String?
}
