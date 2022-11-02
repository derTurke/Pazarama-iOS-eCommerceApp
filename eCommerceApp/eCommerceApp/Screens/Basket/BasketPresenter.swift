//
//  BasketPresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 2.11.2022.
//

import Foundation

final class BasketPresenter: ViewToPresenterBasketProtocol {
    weak var view: PresenterToViewBasketProtocol?
    var interactor: PresenterToInteractorBasketProtocol?
    var router: PresenterToRouterBasketProtocol?
    
    
}

extension BasketPresenter: InteractorToPresenterBasketProtocol {
    func didErrorOccurred(_ error: Error) {
        
    }
}
