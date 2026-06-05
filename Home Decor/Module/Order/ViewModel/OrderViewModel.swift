//
//  OrderViewModel.swift
//  Home Decor
//
//  Created by Dalynn on 6/1/26.
//

import SwiftUI
import Combine
import FirebaseFirestore
import FirebaseAuth

struct OrderModel: Codable, Identifiable {
    var id: String?
    var userID: String
    var items: [ListMenu]
    var totalUSD: Double
    var totalKHR: Double
    var savedAmount: Double
    var status: String
    var createdAt: Date
}

class OrderViewModel: ObservableObject {
    @Published var ordersList: [OrderModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let db = Firestore.firestore()
    private var userID: String? {
        Auth.auth().currentUser?.uid
    }

    init() {
        fetchOrders()
    }
    
    @MainActor
    func placeOrder(
        items: [ListMenu],
        totalUSD: Double,
        totalKHR: Double,
        savedAmount: Double,
        onSuccess: @escaping () -> Void,
        onFailure: @escaping (String) -> Void
    ) async {
        guard let uid = userID else {
            onFailure("User not logged in.")
            return
        }
        guard !items.isEmpty else {
            onFailure("Cart is empty.")
            return
        }

        isLoading = true
        errorMessage = nil

        let orderID = UUID().uuidString
        let order = OrderModel(
            id: orderID,
            userID: uid,
            items: items,
            totalUSD: totalUSD,
            totalKHR: totalKHR,
            savedAmount: savedAmount,
            status: "success",
            createdAt: Date()
        )

        FirebaseLog.shared.logFirebase(
            .fetch,
            collection: "orders/\(uid)/list",
            extra: "Placing order: \(orderID) with \(items.count) item(s)"
        )

        do {
            let encodedItems = try items.map { try DictionaryEncoder.encode($0) }
            let orderData: [String: Any] = [
                "id": orderID,
                "userID": uid,
                "items": encodedItems,
                "totalUSD": totalUSD,
                "totalKHR": totalKHR,
                "savedAmount": savedAmount,
                "status": "success",
                "createdAt": Timestamp(date: order.createdAt)
            ]

            try await db
                .collection("orders")
                .document(uid)
                .collection("list")
                .document(orderID)
                .setData(orderData)

            isLoading = false
            onSuccess()

        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
            print("❌ Failed to place order: \(error.localizedDescription)")
            onFailure(error.localizedDescription)
        }
    }

    func fetchOrders() {
        guard let uid = userID else { return }
        FirebaseLog.shared.logFirebase(.fetch, collection: "orders/\(uid)/list")

        db.collection("orders")
            .document(uid)
            .collection("list")
            .order(by: "createdAt", descending: true)
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self = self else { return }
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    return
                }
                guard let documents = snapshot?.documents else {
                    self.ordersList = []
                    return
                }
                self.ordersList = documents.compactMap { doc -> OrderModel? in
                    let data = doc.data()
                    guard
                        let userID = data["userID"] as? String,
                        let itemsData = data["items"] as? [[String: Any]],
                        let totalUSD = data["totalUSD"] as? Double,
                        let totalKHR = data["totalKHR"] as? Double,
                        let savedAmount = data["savedAmount"] as? Double,
                        let status = data["status"] as? String,
                        let timestamp = data["createdAt"] as? Timestamp
                    else { return nil }

                    let items = itemsData.compactMap { try? DictionaryDecoder.decode(ListMenu.self, from: $0) }
                    return OrderModel(
                        id: doc.documentID,
                        userID: userID,
                        items: items,
                        totalUSD: totalUSD,
                        totalKHR: totalKHR,
                        savedAmount: savedAmount,
                        status: status,
                        createdAt: timestamp.dateValue()
                    )
                }
            }
    }
}
