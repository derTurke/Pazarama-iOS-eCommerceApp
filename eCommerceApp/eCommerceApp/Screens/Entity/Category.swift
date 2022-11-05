//
//  Category.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 4.11.2022.
//

import Foundation

struct Category: Codable {
    let name: String?
}

extension Category {
    init(from dict: [String: Any]) {
        name = dict["name"] as? String
    }
}
