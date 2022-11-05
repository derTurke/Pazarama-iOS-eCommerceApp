//
//  MainTabBarInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 5.11.2022.
//

import Foundation
import FirebaseFirestore

final class MainTabBarInteractor: PresenterToInteractorMainTabBarProtocol {
    weak var presenter: InteractorToPresenterMainTabBarProtocol?
    
    private let db = Firestore.firestore()
    private let defaults = UserDefaults.standard
    
    func fetchBasketTotalPrice() {
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
                baskets.append(Basket(from: document.data()))
            }
            self.calcTotalPrice(with: baskets)
            
        }
    }
    
    func calcTotalPrice(with baskets: [Basket]?) {
        guard let baskets = baskets else {
            return
        }
        var price = 0.0
        for basket in baskets {
            price += basket.totalPrice ?? 0.0
        }
        if price == 0.0 {
            presenter?.didFetchBasketTotalPrice(0.0)
        } else {
            presenter?.didFetchBasketTotalPrice(price)
        }
    }
}
