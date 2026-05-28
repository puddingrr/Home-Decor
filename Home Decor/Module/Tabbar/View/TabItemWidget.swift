//
//  TabItemWidget.swift
//  Home Decor
//
//  Created by Dalynn on 8/25/25.
//
import SwiftUI

struct TabItemWidget: View {
    var icon, activeIcon: ImageResource
    var isSelected: Bool
    var namespace: Namespace.ID 
    var action: () -> Void

    var body: some View {
        ZStack {
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    action()
                }
            } label: {
                VStack {
                    Image(isSelected ? activeIcon : icon)
                        .resizable()
                        .frame(width: 24, height: 24)
                    
                    if isSelected {
                        Color.main
                            .frame(width: 30, height: 2)
                            .matchedGeometryEffect(id: "underline", in: namespace)
                    }
                }
            }
        }
    }
}

struct TabItemModel {
    let icon, activeIcon: ImageResource
}

struct TabsLayoutView: View {
    
    @Binding var selectedTab: Tab
    @Namespace var namespace
    var action: (()-> Void)?
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace, action: {action?()})
            }
        }
        .padding(16)
        .padding(.bottom, 16)
        .frame(height: 80)
        .background(
            RoundedRectangle(cornerRadius: 16)
            .fill(Color.white)
            .shadow(color: .black.opacity(0.1), radius: 2, y: -2))
    }
    
     struct TabButton: View {
        let tab: Tab
        @Binding var selectedTab: Tab
        var namespace: Namespace.ID
        @State private var selectedOffset: CGFloat = 0
        @State private var rotationAngle: CGFloat = 0
        var action: (()-> Void)?
        
        var body: some View {
            Button {
                withAnimation(.easeInOut) {
                    HapticManager.shared.vibrateForSelection()
                    selectedTab = tab
                    action?()
                }
                
                selectedOffset = -60
                if tab < selectedTab {
                    rotationAngle += 360
                } else {
                    rotationAngle -= 360
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    selectedOffset = 0
                    if tab < selectedTab {
                        rotationAngle += 720
                    } else {
                        rotationAngle -= 720
                    }
                }
            } label: {
                ZStack {
                    if isSelected {
                        Capsule()
                            .fill(UserPreference.shared.highlightColor.color.opacity(0.2))
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                    }
                    HStack(spacing: 10) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(isSelected ? UserPreference.shared.highlightColor.color : .black.opacity(0.6))
                            .rotationEffect(.degrees(rotationAngle))
                            .scaleEffect(isSelected ? 1 : 0.9)
                            .animation(.easeInOut, value: rotationAngle)
                            .opacity(isSelected ? 1 : 0.7)
                            .padding(.leading, isSelected ? 20 : 0)
                            .padding(.horizontal, selectedTab != tab ? 10 : 0)
                            .offset(y: selectedOffset)
                            .animation(.default, value: selectedOffset)
                        
                        if isSelected {
                            Text(tab.title)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(UserPreference.shared.highlightColor.color)
                                .padding(.trailing, 20)
                        }
                    }
                    .padding(.vertical, 0)
                }
            }
            .buttonStyle(.plain)
        }
        
        var isSelected: Bool {
            selectedTab == tab
        }
    }
}
