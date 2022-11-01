//
//  Basket.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import Foundation

struct Basket: Codable {
    let productId: Int?
    let title: String?
    let image: String?
    let piece: Int?
    let price: Double?
}
