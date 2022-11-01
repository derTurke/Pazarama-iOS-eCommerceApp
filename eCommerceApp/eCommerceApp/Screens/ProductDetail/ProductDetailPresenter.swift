//
//  ProductDetailPresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 31.10.2022.
//

import Foundation

final class ProductDetailPresenter: ViewToPresenterProductDetailProtocol {
    
    weak var view: PresenterToViewProductDetailProtocol?
    
    var interactor: PresenterToInteractorProductDetailProtocol?
    
    var router: PresenterToRouterProductDetailProtocol?
    
    func viewDismiss() {
        router?.dismiss(on: view!)
    }
    
    func getProduct() {
        interactor?.fetchProduct()
    }
    
    func addBasket(_ product: Products?, piece: Int?) {
        interactor?.addBasketToFirestore(product, piece: piece)
    }
    
    func updatePriceAndPieceLabel(_ product: Products?, piece: Double?) {
        guard let product = product,
              let productPrice = product.price,
              let piece = piece else {
            return
        }
        let price = productPrice * piece
        view?.didUpdatePriceAndPieceLabel(price: price, piece: Int(piece))
    }
    
}

extension ProductDetailPresenter: InteractorToPresenterProductDetailProtocol {
    func didErrorOccurred(_ error: Error) {
        view?.didErrorOccurred(error)
    }
    
    func didFetchProduct(_ product: Products) {
        view?.didGetProduct(product)
    }
    
    func didAddBasketToFirestore() {
        view?.didAddBasket()
    }
}
