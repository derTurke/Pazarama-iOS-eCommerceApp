//
//  Basket.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import Foundation

struct Basket: Codable {
    let id: String?
    let productId: Int?
    let title: String?
    let image: String?
    let piece: Int?
    let price: Double?
}

extension Basket {
    init(from dict: [String: Any]) {
        id = dict["id"] as? String
        productId = dict["productId"] as? Int
        title = dict["title"] as? String
        image = dict["image"] as? String
        piece = dict["piece"] as? Int
        price = dict["price"] as? Double
    }
}
