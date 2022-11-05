//
//  SplashPresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 30.10.2022.
//

import UIKit

final class SplashPresenter: ViewToPresenterSplashProtocol {
    weak var view: PresenterToViewSplashProtocol?
    
    var interactor: PresenterToInteractorSplashProtocol?
    
    var router: PresenterToRouterSplashProtocol?
    
    func getProducts() {
        interactor?.fetchProducts()
    }
    
    func getCategories() {
        interactor?.fetchCategories()
    }
    
    func getUserDefaults() {
        interactor?.fetchUserDefaults()
    }
}

extension SplashPresenter: InteractorToPresenterSplashProtocol {
    func didErrorOccurred(_ error: Error) {
        view?.didErrorOccurred(error)
    }
    
    func didFetchProducts() {
        view?.didGetProducts()
    }
    func didFetchUserDefaults(with viewController: UIViewController) {
        view?.didGetUserDefaults()
        router?.pushToView(on: view!, with: viewController)
    }
}
