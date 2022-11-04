//
//  SearchRouter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import UIKit

final class SearchRouter: PresenterToRouterSearchProtocol {
    static func createModule() -> UIViewController {
        let viewController = SearchViewController()
        let presenter: ViewToPresenterSearchProtocol & InteractorToPresenterSearchProtocol = SearchPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = SearchRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SearchInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func pushToProductDetail(on view: PresenterToViewSearchProtocol, with product: Products) {
        let productDetailViewController = ProductDetailRouter.createModule(product)
        productDetailViewController.modalPresentationStyle = .fullScreen
        productDetailViewController.modalTransitionStyle = .crossDissolve
        let viewController = view as! SearchViewController
        viewController.present(productDetailViewController, animated: true)
    }
    
}
