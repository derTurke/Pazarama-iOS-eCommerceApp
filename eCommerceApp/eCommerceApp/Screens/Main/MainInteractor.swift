//
//  MainInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import Foundation
import FirebaseFirestore

final class MainInteractor: PresenterToInteractorMainProtocol {
    weak var presenter: InteractorToPresenterMainProtocol?
    
    private let db = Firestore.firestore()
    
    func fetchProducts() {
        db.collection("products").getDocuments() { querySnapshot, error in
            if let error {
                self.presenter?.didErrorOccurred(error)
                return
            }
            guard let documents = querySnapshot?.documents else {
                return
            }
            var products = [Products]()
            for document in documents {
                products.append(Products(from: document.data()))
            }
            self.presenter?.didFetchProducts(products)
        }
    }
}
