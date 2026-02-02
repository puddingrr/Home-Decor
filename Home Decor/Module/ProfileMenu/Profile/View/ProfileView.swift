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
        VStack(spacing: 0) {
            ScrollViewReader { proxy in
                ScrollView(showsIndicators: false) {
                    GeometryReader { geo in
                        Color.clear
                            .onChange(of: geo.frame(in: .global).minY) { scrollOffset in
                                contentOffset = nil // reset it to make action scroll to offset work
                            }
                    }
                    .frame(height: 0)
                    LazyVStack(spacing: 7, pinnedViews: [.sectionHeaders]) {
                        navBarTop
                        Section {
                            VStack {
                                ProfileSectionView(title: "Profile Info",
                                                   items: profileVM.profileInfoList, isNavigated: $isNavigated, selectedButton: $selectedButton)
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
                            .padding(.horizontal, 16)
                        } header: {
                            HStack {
                                menuCard(image: .myprofile, text: "Profile") {}
                                menuCard(image: .wishlistActive, text: "Wishlist") {}
                                menuCard(image: .myOrder, text: "My Orders", isLast: false) {
                                    profileVM.isOrder.toggle()
                                }
                            }
                            .frame(height: 81)
                            .background(Color.main)
                        }
                    }
                     .scrollToOffset(contentOffset: $contentOffset)
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
    }
    
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

extension ProfileView {
    var navBarTop: some View {
        VStack(spacing: 0) {
            if let image = profileVM.localProfileImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            } else {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 100)
                    .overlay {
                        Image(.myprofile)
                            .resizable()
                            .frame(width: 40, height: 40)
                    }
            }
            VStack {
                TextSwifUI(title: profileVM.currentUser?.fullName ?? "Guest", size: .huge, weight: .bold)
                TextSwifUI(title: profileVM.currentUser?.email ?? "No Email", size: .small)
            }
        }
        .background(.main)
        .ignoresSafeArea(edges: .top)
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

struct ScrollOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
