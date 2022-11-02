//
//  BasketInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 2.11.2022.
//

import Foundation
import FirebaseFirestore

final class BasketInteractor: PresenterToInteractorBasketProtocol {
    weak var presenter: InteractorToPresenterBasketProtocol?
    
    private let db = Firestore.firestore()
    private let defaults = UserDefaults.standard
    
    func fetchBasket() {
        guard let uid = defaults.string(forKey: "uid") else {
            return
        }
        db.collection("baskets").document("users").collection(uid).getDocuments() { querySnapshot, error in
            if let error {
                self.presenter?.didErrorOccurred(error)
                return
            }
            guard let documents = querySnapshot?.documents else {
                return
            }
            var baskets = [Basket]()
            for document in documents {
                var basket = document.data()
                basket["id"] = document.documentID
                baskets.append(Basket(from: basket))
            }
            self.presenter?.didFetchBasket(baskets)
        }
    }
    
    func updateBasket(_ basket: Basket?) {
        
    }
    
    func paymentBasket() {
        
    }
    
    func deleteProductInBasket(_ basket: Basket?) {
        guard let uid = defaults.string(forKey: "uid"),
              let basket = basket,
              let basketId = basket.id else {
            return
        }
        db.collection("baskets").document("users").collection(uid).document(basketId).delete() { error in
            if let error {
                self.presenter?.didErrorOccurred(error)
                return
            }
            self.fetchBasket()
        }
        
    }
}
