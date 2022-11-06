//
//  Basket.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import Foundation

struct Basket: Codable {
    var id: String?
    var productId: Int?
    var title: String?
    var image: String?
    var piece: Int?
    var price: Double?
    var totalPrice: Double?
}

extension Basket {
    init(from dict: [String: Any]) {
        id = dict["id"] as? String
        productId = dict["productId"] as? Int
        title = dict["title"] as? String
        image = dict["image"] as? String
        piece = dict["piece"] as? Int
        price = dict["price"] as? Double
        totalPrice = dict["totalPrice"] as? Double
    }
}
