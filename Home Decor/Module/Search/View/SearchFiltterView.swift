//
//  SearchFiltterView.swift
//  Home Decor
//
//  Created by Dalynn on 8/27/25.
//

import SwiftUI

struct SearchFiltterView: View {
    @State private var priceValue: Double = 500
    @State var selectedIndex: Int = 2
    @State var selectedProduct: Int = 2
    @State var selctedColor: Int = 1
    let list: [String] = ["Bedroom", "Office", "Living Room", "Dining Room", "Kitchen"]
    let listProduct: [String] = ["Sofa", "Tables", "Cupboards", "Office Chairs", "Desktop Lamp", "Puff Chair", "Decor", "Nightstand"]
    let colorlist: [Color] = [.lightPurple, .lightBlue, .lightGreen, .orange, .black, .softPink]
    var body: some View {
        VStack {
            TextSwifUI(title: "Filter", size: 20, color: .selectPink, weight: .bold)
                .padding(.vertical, 12)
            
            VStack(alignment: .leading, spacing: 12) {
                TextSwifUI(title: "Price Range", size: 16, color: .selectPink, weight: .medium)
                
                BudgetSlider(value: $priceValue)
                
                HStack {
                    Spacer()
                    Text("Selected: $\(Int(priceValue))")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.gray)
                }
                TextSwifUI(title: "Categories", size: 16, color: .selectPink, weight: .medium)
                
                FlowLayout(spacing: 12) {
                    ForEach(0..<list.count, id: \.self) { i in
                        Button {
                            selectedIndex = i
                        } label: {
                            TextSwifUI(title: list[i], color: selectedIndex == i ? .selectPink : .softPink, weight: .regular)
                                .padding(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                                .background(selectedIndex == i ? Color.main.cornerRadius(12) : Color.lightOrange.cornerRadius(12))
                        }
                    }
                }
                
                TextSwifUI(title: "Products", size: 16, color: .selectPink, weight: .medium)
                FlowLayout(spacing: 12) {
                    ForEach(0..<listProduct.count, id: \.self) { i in
                        Button {
                            selectedProduct = i
                        } label: {
                            TextSwifUI(title: listProduct[i], color: selectedProduct == i ? .selectPink : .softPink, weight: .regular)
                                .padding(EdgeInsets(top: 6, leading: 20, bottom: 6, trailing: 20))
                                .background(selectedProduct == i ? Color.main.cornerRadius(12) : Color.lightOrange.cornerRadius(12))
                        }
                    }
                }
                TextSwifUI(title: "Colors", size: 16, color: .selectPink, weight: .medium)
                HStack {
                    ForEach(colorlist.indices, id: \.self) { i in
                        Button {
                            selctedColor = i
                        } label: {
                            Circle()
                                .fill(colorlist[i])
                                .frame(width: 30, height: 30)
                                .overlay(
                                    ZStack {
                                        Circle()
                                            .stroke(selctedColor == i ? Color.white : Color.clear, lineWidth: 2)
                                        Circle()
                                            .stroke(selctedColor == i ? Color.black : Color.clear, lineWidth: 1)
                                            .frame(width: 37, height: 37)
                                    }
                                )
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.top, 8)
            }
            Button {
              
            } label: {
                TextSwifUI(title: "Apply", size: 20, color: .selectPink, weight: .bold)
                    .frame(width: 175, height: 39)
                    .background(Color.main.cornerRadius(20))
                
            }
            .padding(.top, 16)
            Spacer()
        }
        .padding(16)
    }
}

struct BudgetSlider: View {
    @Binding var value: Double
    
    let minValue: Double = 100
    let maxValue: Double = 1500
    let tickValues: [Double] = [100, 500, 1000, 1500]
    
    var body: some View {
        VStack(spacing: 20) {
            GeometryReader { geo in
                let sliderWidth = geo.size.width
                let progress = CGFloat((value - minValue) / (maxValue - minValue))
                let thumbX = progress * sliderWidth
                
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color.lightOrange)
                        .frame(height: 10)
                    
                    Capsule()
                        .fill(Color.main)
                        .frame(width: thumbX, height: 10)
                    
                    Circle()
                        .fill(Color.main)
                        .overlay(Circle().stroke(Color.selectPink, lineWidth: 2.5))
                        .frame(width: 24, height: 24)
                        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 2)
                        .offset(x: thumbX - 12)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    let newLocation = gesture.location.x
                                    let clampedX = max(0, min(newLocation, sliderWidth))
                                    let ratio = clampedX / sliderWidth
                                    let newValue = minValue + Double(ratio) * (maxValue - minValue)
                                    value = newValue
                                }
                        )
                }
            }
            .frame(height: 30)
            
            HStack {
                ForEach(tickValues, id: \.self) { tick in
                    Text("$\(Int(tick))")
                        .font(.system(size: 14))
                    if tick != tickValues.last {
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 8)
        }
    }
}
