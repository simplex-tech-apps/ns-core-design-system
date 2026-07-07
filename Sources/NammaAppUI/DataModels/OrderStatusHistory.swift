//
//  OrderStatusHistoryData.swift
//  NammaAppUI
//
//  Created by apple on 13/09/25.
//


let orderStatusHistoryList: [OrderStatusHistoryModel] = [OrderStatusHistoryModel(id: 1, title: "Pending"), OrderStatusHistoryModel(id: 2, title: "Confirmed"), OrderStatusHistoryModel(id: 3, title: "Reached Shop"), OrderStatusHistoryModel(id: 4, title: "Preparing"), OrderStatusHistoryModel(id: 5, title: "Out for delivery")]

struct OrderStatusHistoryModel {
    var id: Int
    var title: String
}
