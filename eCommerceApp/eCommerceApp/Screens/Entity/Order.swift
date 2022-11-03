//
//  Order.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 3.11.2022.
//

import Foundation

struct Order: Codable {
    let id: String?
    let productId: Int?
    let title: String?
    let image: String?
    let piece: Int?
    let price: Double?
    let totalPrice: Double?
    let orderDate: Date?
}

extension Order {
    init(from dict: [String: Any]) {
        id = dict["id"] as? String
        productId = dict["productId"] as? Int
        title = dict["title"] as? String
        image = dict["image"] as? String
        piece = dict["piece"] as? Int
        price = dict["price"] as? Double
        totalPrice = dict["totalPrice"] as? Double
        orderDate = dict["orderDate"] as? Date
    }
}
