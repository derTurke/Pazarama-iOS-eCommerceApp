//
//  FakeStoreAPI.swift
//  eCommerceAppAPI
//
//  Created by GÜRHAN YUVARLAK on 30.10.2022.
//

import Foundation
import Moya

public let fakeStoreProvider = MoyaProvider<FakeStoreApi>()

public enum FakeStoreApi {
    case getProducts
    case getSingleProduct(_ id: Int)
    case getCategories
}

extension FakeStoreApi: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: "https://fakestoreapi.com/products") else {
            fatalError("Base URL not found or not in correct format.")
        }
        return url
    }
    
    public var path: String {
        switch self {
            case .getProducts:
                return "/"
            case .getSingleProduct(let id):
                return "/\(id)"
            case .getCategories:
                return "/categories"
        }
    }
    
    public var method: Moya.Method {
        .get
    }
    
    public var task: Moya.Task {
        .requestPlain
    }
    
    public var headers: [String : String]? {
        nil
    }
    
    
}
