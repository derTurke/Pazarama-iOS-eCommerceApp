//
//  BasketRouter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 2.11.2022.
//

import UIKit

final class BasketRouter: PresenterToRouterBasketProtocol {
    static func createModule() -> UIViewController {
        let viewController = BasketViewController()
        let presenter: ViewToPresenterBasketProtocol & InteractorToPresenterBasketProtocol = BasketPresenter()
        viewController.presenter = presenter
        viewController.presenter.router = BasketRouter()
        viewController.presenter.view = viewController
        viewController.presenter.interactor = BasketInteractor()
        viewController.presenter.interactor?.presenter = presenter
        return viewController
    }
    
    func dismiss(on view: PresenterToViewBasketProtocol) {
        let viewController = view as! BasketViewController
        viewController.dismiss(animated: true)
    }
    
    
}
