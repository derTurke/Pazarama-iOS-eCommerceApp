//
//  MainTabBarPresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 5.11.2022.
//

import Foundation

final class MainTabBarPresenter: ViewToPresenterMainTabBarProtocol {
    weak var view: PresenterToViewMainTabBarProtocol?
    var interactor: PresenterToInteractorMainTabBarProtocol?
    var router: PresenterToRouterMainTabBarProtocol?
    
    var totalPrice: Double? {
        didSet {
            guard let totalPrice = totalPrice else {
                return
            }
            view?.didGetBasketTotalPrice(totalPrice)
        }
    }
    
    func getBasketTotalPrice() {
        interactor?.fetchBasketTotalPrice()
    }
    
    func presentBasket() {
        router?.presentBasket(on: view!)
    }
}

extension MainTabBarPresenter: InteractorToPresenterMainTabBarProtocol {
    func didErrorOccurred(_ error: Error) {
        view?.didErrorOccurred(error)
    }
    
    func didFetchBasketTotalPrice(_ totalPrice: Double?) {
        self.totalPrice = totalPrice
    }
}
