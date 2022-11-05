//
//  AuthEntity.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import Foundation

struct User: Codable {
    let uid: String?
    let username: String?
    let email: String?
    let password: String?
    let passwordAgain: String?
}

extension User {
    init(from dict: [String: Any]) {
        uid = dict["uid"] as? String
        username = dict["username"] as? String
        email = dict["email"] as? String
        password = dict["password"] as? String
        passwordAgain = dict["passwordAgain"] as? String
    }
}
