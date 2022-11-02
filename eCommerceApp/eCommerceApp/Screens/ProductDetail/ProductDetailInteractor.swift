//
//  ProductDetailInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 31.10.2022.
//

import Foundation
import FirebaseFirestore
import eCommerceAppAPI

final class ProductDetailInteractor: PresenterToInteractorProductDetailProtocol {

    weak var presenter: InteractorToPresenterProductDetailProtocol?
    
    var product: Products?
    
    private let db = Firestore.firestore()
    
    private let defaults = UserDefaults.standard
    
    private let notificationCenter: NotificationCenter = NotificationCenter.default
    
    func fetchProduct() {
        guard let product = product,
              let productId = product.id else {
            return
        }
        fakeStoreProvider.request(.getSingleProduct(productId)) { result in
            switch result {
                case .success(let response):
                do {
                    let product = try JSONDecoder().decode(Products.self, from: response.data)
                    self.updateProductInFirestore(product: product)
                    self.product = product
                    self.presenter?.didFetchProduct(product)
                } catch {
                    self.presenter?.didErrorOccurred(error)
                }
                case .failure(let error):
                    self.presenter?.didErrorOccurred(error)
            }
        }
    }
    
    func updateProductInFirestore(product: Products?) {
        guard let product = product,
              let productId = product.id else {
            return
        }
        do {
            guard let data = try product.dictionary else { return }
            self.db.collection("products").document("\(productId)").setData(data) { error in
                if let error {
                    self.presenter?.didErrorOccurred(error)
                    return
                }
            }
        } catch {
            self.presenter?.didErrorOccurred(error)
        }
    }
    
    func addBasketToFirestore(_ product: Products?, piece: Int?) {
        guard let product = product,
              let uid = defaults.string(forKey: "uid"),
              let price = product.price,
              let piece = piece,
              let productId = product.id,
              let productTitle = product.title,
              let productImage = product.image else {
            return
        }
        let totalPrice = price * Double(piece)
        let basket = Basket(productId: productId, title: productTitle, image: productImage, piece: piece, price: totalPrice)
        do {
            guard let data = try basket.dictionary else { return }
            self.db.collection("baskets").document("users").collection(uid).addDocument(data: data) { error in
                if let error {
                    self.presenter?.didErrorOccurred(error)
                    return
                }
                self.presenter?.didAddBasketToFirestore()
                self.notificationCenter.post(name: .getBasketTotalPrice, object: nil)
            }
        } catch {
            self.presenter?.didErrorOccurred(error)
        }
    }
    
    
}
