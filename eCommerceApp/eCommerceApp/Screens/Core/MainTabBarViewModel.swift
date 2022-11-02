//
//  MainTabBarInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import Foundation
import FirebaseFirestore

protocol MainTabBarDelegate: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didFetchTotalPrice(_ totalPrice: Double)
}

final class MainTabBarViewModel {
    
    weak var delegate: MainTabBarDelegate?
    
    var totalPrice: Double? {
        didSet {
            guard let totalPrice = totalPrice else {
                return
            }
            delegate?.didFetchTotalPrice(totalPrice)
        }
    }
    
    private let db = Firestore.firestore()
    private let defaults = UserDefaults.standard
    
    func fetchBasketTotalPrice() {
        guard let uid = defaults.string(forKey: "uid") else {
            return
        }
        db.collection("baskets").document("users").collection(uid).getDocuments() { querySnapshot, error in
            if let error {
                self.delegate?.didErrorOccurred(error)
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
    
    private func calcTotalPrice(with baskets: [Basket]?) {
        guard let baskets = baskets else {
            return
        }
        var price = 0.0
        for basket in baskets {
            price += basket.price ?? 0.0
        }
        if price == 0.0 {
            totalPrice = 0.0
        } else {
            totalPrice = price
        }
        
    }
    
}
