//
//  MainInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import Foundation

final class MainInteractor: PresenterToInteractorMainProtocol {
    weak var presenter: InteractorToPresenterMainProtocol?
    
    func fetchProducts() {
        print("fetchProducts")
    }
}
