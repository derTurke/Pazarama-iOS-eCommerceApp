//
//  ErrorHandling.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import Foundation
enum AuthError: Error {
    case emptyUsername
    case emptyEmail
    case emptyPassword
    case doesNotMatchPassword
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .emptyUsername:
                return NSLocalizedString("Username cannot be empty!", comment: "")
            case .emptyEmail:
                return NSLocalizedString("Email cannot be empty!", comment: "")
            case .emptyPassword:
                return NSLocalizedString("Password cannot be empty!", comment: "")
            case .doesNotMatchPassword:
                return NSLocalizedString("Passwords do not match!", comment: "")
        }
    }
}
