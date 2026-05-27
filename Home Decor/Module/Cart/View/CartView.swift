//
//  CartView.swift
//  Home Decor
//
//  Created by Dalynn on 12/15/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct CartView: View {
    @EnvironmentObject var cartVM: CartViewModel
    
    @State private var editMode: EditMode = .inactive
    @State private var selectedItems: Set<String> = []
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavBar(
                title: "My Cart",
                trailingBtnIcon: editMode == .active ? "pencil.and.list.clipboard" : "pencil.and.list.clipboard",
                isBack: false,
                isShadow: true,
                actionTrailingIcon: {
                    withAnimation {
                        editMode = editMode == .active ? .inactive : .active
                        if editMode == .inactive { selectedItems.removeAll() }
                    }
                }
            )
            
            if !cartVM.cartItems.isEmpty {
                ScrollView(showsIndicators: false) {
                    VStack {
                        ForEach(cartVM.cartItems) { item in
                            HStack(alignment: .top, spacing: 10) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 89, height: 89)
                                        .foregroundColor(Color.lightOrange)
                                    if let image = item.image {
                                        WebImage(url: URL(string: image))
                                            .resizable()
                                            .frame(width: 69, height: 69)
                                            .cornerRadius(10)
                                    }
                                }
                                
                                VStack(alignment: .leading, spacing: 6) {
                                    TextSwifUI(title: item.title ?? "", size: .other(16), color: .selectPink)
                                    TextSwifUI(title: "$\(item.price ?? "")", size: .other(16))
                                }
                                
                                Spacer()
                                
                                if editMode == .inactive {
                                    HStack(spacing: 8) {
                                        Button { decreaseItem(item) } label: {
                                            Image(.dicrease).resizable().frame(width: 24, height: 24)
                                        }
                                        TextSwifUI(title: "\(item.quantity ?? 1)", weight: .bold)
                                        Button { increaseItem(item) } label: {
                                            Image(.increase).resizable().frame(width: 24, height: 24)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 30)
                    .environment(\.editMode, .constant(editMode))
                }
                
                Spacer()
                if editMode == .active {
                    VStack {
                        HStack {
//                            Button(action: toggleSelectAll) {
//                                HStack {
//                                    Image(systemName: selectedItems.count == cartVM.cartItems.count ? "checkmark.square.fill" : "square")
//                                    Text(selectedItems.count == cartVM.cartItems.count ? "Deselect All" : "Select All")
//                                }
//                            }
//                            Spacer()
//                            Button(action: removeSelectedItems) {
//                                Text("Remove (\(selectedItems.count))")
//                                    .foregroundColor(.red)
//                            }
                        }
                    }
                    .padding()
                    .background(Color.white)
                }
            } else {
                NoDataView()
            }
        }
    }
    
    // MARK: - Helper Functions
    private func increaseItem(_ item: ListMenu) {
        guard let index = cartVM.cartItems.firstIndex(where: { $0.id == item.id }) else { return }
        let currentQty = cartVM.cartItems[index].quantity ?? 1
        cartVM.cartItems[index].quantity = currentQty + 1
        Task { await cartVM.updateItem(cartVM.cartItems[index]) }
    }
    
    private func decreaseItem(_ item: ListMenu) {
        guard let index = cartVM.cartItems.firstIndex(where: { $0.id == item.id }) else { return }
        let currentQty = cartVM.cartItems[index].quantity ?? 1

        if currentQty > 1 {
            cartVM.cartItems[index].quantity = currentQty - 1
            Task { await cartVM.updateItem(cartVM.cartItems[index]) }
        } else {
            Task {
                await cartVM.removeFromCart(cartVM.cartItems[index])
            }
        }
    }
    
    private func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            let item = cartVM.cartItems[index]
            Task { await cartVM.removeFromCart(item) }
        }
    }
    
//    private func toggleSelectAll() {
//        if selectedItems.count == cartVM.cartItems.count {
//            selectedItems.removeAll()
//        } else {
//            selectedItems = Set(cartVM.cartItems.map { $0.id })
//        }
//    }
//    
//    private func removeSelectedItems() {
//        let itemsToRemove = cartVM.cartItems.filter { selectedItems.contains. map ($0.id) }
//        Task {
//            for item in itemsToRemove {
//                await cartVM.removeFromCart(item)
//            }
//            selectedItems.removeAll()
//        }
//    }
}
struct NoDataView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(.cartEmpty)
                .resizable()
                .frame(width: 200, height: 200)
            TextSwifUI(title: "There are no items in your cart", size: .other(16), weight: .bold)
            Spacer()
        }
    }
}
