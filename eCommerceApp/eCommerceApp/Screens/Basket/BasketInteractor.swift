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
    private let notificationCenter: NotificationCenter = NotificationCenter.default
    
    var totalPrice: Double? {
        didSet {
            guard let totalPrice = totalPrice else {
                return
            }
            presenter?.didFetchTotalPrice(totalPrice)
        }
    }
    
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
            self.calcTotalPrice(with: baskets)
            self.notificationCenter.post(name: .getBasketTotalPrice, object: nil)
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
            totalPrice = 0.0
        } else {
            totalPrice = price
        }
    }
    
    func updateBasket(_ basket: Basket?, piece: Double?) {
        guard var basket = basket,
              let basketId = basket.id,
              let price = basket.price,
              let piece = piece,
              let uid = defaults.string(forKey: "uid") else{
            return
        }
        basket.piece = Int(piece)
        basket.totalPrice = price * piece
        do {
            guard let data = try basket.dictionary else { return }
            db.collection("baskets").document("users").collection(uid).document(basketId).setData(data) { error in
                if let error {
                    self.presenter?.didErrorOccurred(error)
                    return
                }
                self.fetchBasket()
            }
        } catch {
            self.presenter?.didErrorOccurred(error)
        }
    }
    
    func paymentBasket() {
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
//            var orders = [Order]()
            for document in documents {
                var data = document.data()
                data["id"] = document.documentID
                self.deleteBasketsInFirestore(Basket(from: data))
//                data["orderDate"] = Date()
//                orders.append(Order(from: data))
            }
            self.notificationCenter.post(name: .getBasketTotalPrice, object: nil)
            self.presenter?.didPaymentBasket()
//            MARK: - ADD TO ORDER
//            self.basketAddToOrderFirestore(orders)
            
        }
    }
    
    func deleteBasketsInFirestore(_ basket: Basket?) {
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
        }
    }
    
//    MARK: - ADD TO ORDER
//    func basketAddToOrderFirestore(_ orders: [Order]?) {
//        guard let orders = orders,
//              let uid = defaults.string(forKey: "uid") else {
//            return
//        }
//        do {
//            for order in orders {
//                guard let data = try order.dictionary else { return }
//                db.collection("orders").document(uid).collection("order").document().collection("products").addDocument(data: data){ error in
//                    if let error {
//                        self.presenter?.didErrorOccurred(error)
//                        return
//                    }
//                }
//            }
//            self.notificationCenter.post(name: .getBasketTotalPrice, object: nil)
//            self.presenter?.didPaymentBasket()
//        } catch {
//            self.presenter?.didErrorOccurred(error)
//        }
//    }
    
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
