//
//  ProfileView.swift
//  Home Decor
//
//  Created by Dalynn on 8/28/25.
//
import SwiftUI


struct ProfileView: View {
    
    @StateObject var profileVM = ProfileViewModel()
    @EnvironmentObject var mainVM: MainViewModel
    
    //State
    @State var isNavigated: Bool = false
    @State var selectedButton: String = ""
    @State var contentOffset: CGPoint?
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.appBackground.ignoresSafeArea()
            VStack(spacing: 0) {
                navBarTop
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                       
                        VStack(spacing: 16) {
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
                    }
                    .padding(.top, 16)
                    .padding(.horizontal)
                }
            }
        }
        .onAppear {
            profileVM.loadUser()
        }
        .navigationDestination(isPresented: $profileVM.isOrder) {
            MyOrderView(viewModel: profileVM)
        }
        .navigationDestination(isPresented: $profileVM.isSelectedEdit) {
            EditProfileView(viewModel: profileVM)
        }
        .navigationDestination(isPresented: $isNavigated) {
            if let selectedType = getButtonNavigationType(for: selectedButton) {
                selectedType.destinationView()
            }
        }
    }
    
    @ViewBuilder
    func menuCard(image: String, text: String, action: (()-> Void)?) -> some View {
        VStack {
            Button {
                action?()
            } label: {
                VStack(spacing: 8) {
                    Image(systemName: image)
                        .resizable()
                        .foregroundColor(UserPreference.shared.highlightColor.color)
                        .frame(width: 24, height: 24)
                    TextSwifUI(title: text, color: .authBg)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

extension ProfileView {
    var navBarTop: some View {
        ZStack {
            UserPreference.shared.highlightColor.color.ignoresSafeArea()
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    if let image = profileVM.localProfileImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    } else {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 50, height: 50)
                            .overlay {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .foregroundColor(.white)
                                    .frame(width: 50, height: 50)
                            }
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        TextSwifUI(title: profileVM.currentUser?.fullName ?? "Guest", size: .huge, color: .white, weight: .bold)
                        TextSwifUI(title: profileVM.currentUser?.email ?? "No Email", size: .small, color: .white)
                    }
                    Spacer(minLength: 0)
                    HStack(alignment: .top) {
                        VStack(spacing: 6) {
                            Image(systemName: "network")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                            TextSwifUI(title: "Language", color: .white)
                        }
                        VStack(spacing: 6) {
                            Image(systemName: "gearshape")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: 24, height: 24)
                            TextSwifUI(title: "Setting", color: .white)
                        }
                    }
                }
//                HStack(spacing: 8) {
//                    TextSwifUI(title: "My Orders", size: .medium)
//                    Spacer(minLength: 0)
//                    TextSwifUI(title: "View")
//                    Image(.arrowRight)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 8, height: 14)
//                }
                HStack {
                    menuCard(image: "wallet.bifold", text: "Pay") {}
                    menuCard(image: "shippingbox", text: "Ship") {}
                    menuCard(image: "truck.box", text: "Recive") {
                        profileVM.isOrder.toggle()
                    }
                    menuCard(image: "ellipsis.bubble", text: "Review") {}
                    menuCard(image: "arrow.trianglehead.rectanglepath", text: "Refunds") {}
                }
                .padding(16)
                .background(Color.darkCardBG)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                )
                .padding(.top, 10)
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 170)
    }
    
    func getButtonNavigationType(for selectedButton: String) -> ButtonNavigationType? {
        switch selectedButton {
        case "Appearance":
            return .appearance
        default:
            return nil
        }
    }
}

struct ItemModel {
    let image: String
    let title: String
    var secondTitle: String?
}

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
