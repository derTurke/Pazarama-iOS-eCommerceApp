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
    
    func getProducts() {
        print("getProducts")
        interactor?.fetchProducts()
    }
}

extension MainPresenter: InteractorToPresenterMainProtocol {
    func didErrorOccurred(_ error: Error) {
        
    }
    
    func didFetchProducts() {
        
    }
}
