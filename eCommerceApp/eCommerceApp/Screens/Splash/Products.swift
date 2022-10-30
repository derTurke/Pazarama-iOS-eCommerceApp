//
//  SplashEntity.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 30.10.2022.
//
import Foundation

// MARK: - Products
struct Products: Codable {
    let id: Int?
    let title: String?
    let price: Double?
    let welcomeDescription: String?
    let category: String?
    let image: String?
    let rating: Rating?

    enum CodingKeys: String, CodingKey {
        case id, title, price
        case welcomeDescription = "description"
        case category, image, rating
    }
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double?
    let count: Int?
}

extension Products {
    init(from dict: [String: Any]) {
        id = dict["id"] as? Int
        title = dict["title"] as? String
        price = dict["price"] as? Double
        welcomeDescription = dict["description"] as? String
        category = dict["category"] as? String
        image = dict["image"] as? String
        rating = dict["rating"] as? Rating
    }
}

extension Rating {
    init(from dict: [String: Any]) {
        rate = dict["rate"] as? Double
        count = dict["count"] as? Int
    }
}
