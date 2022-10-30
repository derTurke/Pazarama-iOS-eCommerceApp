//
//  MainPresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import Foundation

final class MainPresenter: ViewToPresenterMainProtocol {
    weak var view: PresenterToViewMainProtocol?
    
    var interactor: PresenterToInteractorMainProtocol?
    
    var router: PresenterToRouterMainProtocol?
    
    var products: [Products]? {
        didSet {
            numberOfItemsInSection = products?.count
        }
    }
    
    var numberOfItemsInSection: Int?
    
    func getProducts() {
        interactor?.fetchProducts()
    }
}

extension MainPresenter: InteractorToPresenterMainProtocol {
    func didErrorOccurred(_ error: Error) {
        view?.didErrorOccurred(error)
    }
    
    func didFetchProducts(_ products: [Products]) {
        self.products = products
        view?.didGetProducts()
    }
}
