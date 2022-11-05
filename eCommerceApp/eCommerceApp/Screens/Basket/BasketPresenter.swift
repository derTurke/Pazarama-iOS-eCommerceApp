//
//  BasketPresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 2.11.2022.
//

import UIKit

final class BasketPresenter: ViewToPresenterBasketProtocol {
    weak var view: PresenterToViewBasketProtocol?
    var interactor: PresenterToInteractorBasketProtocol?
    var router: PresenterToRouterBasketProtocol?
    
    var baskets: [Basket]? {
        didSet {
            numberOfRowsInSection = baskets?.count ?? .zero
        }
    }
    
    var numberOfRowsInSection: Int = .zero
    
    func getBasket() {
        interactor?.fetchBasket()
    }
    
    func updateBasket(_ basket: Basket?, piece: Double?) {
        interactor?.updateBasket(basket, piece: piece)
    }
    
    func buyBasket() {
        interactor?.paymentBasket()
    }
    
    func deleteProduct(_ basket: Basket?) {
        interactor?.deleteProductInBasket(basket)
    }
    
    func productForIndexPath(_ indexPath: IndexPath) -> Basket? {
        baskets?[indexPath.row]
    }
    
    func heightForRowAt() -> CGFloat {
        150
    }
}

extension BasketPresenter: InteractorToPresenterBasketProtocol {
    func didErrorOccurred(_ error: Error) {
        view?.didErrorOccurred(error)
    }
    
    func didFetchBasket(_ baskets: [Basket]?) {
        self.baskets = baskets
        view?.didGetBasket()
    }
    
    func didFetchTotalPrice(_ totalPrice: Double?) {
        guard let totalPrice = totalPrice else { return }
        view?.didGetTotalPrice(totalPrice)
    }
    
    func didPaymentBasket() {
        view?.didBuyBasket()
    }
}
