//
//  MainTabBarRouter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 5.11.2022.
//

import UIKit

final class MainTabBarRouter: PresenterToRouterMainTabBarProtocol {
    static func createModule() -> UITabBarController {
        let viewController = MainTabBarController()
        let presenter: ViewToPresenterMainTabBarProtocol & InteractorToPresenterMainTabBarProtocol = MainTabBarPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = MainTabBarRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MainTabBarInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func presentBasket(on view: PresenterToViewMainTabBarProtocol) {
        let basketNavigationController = UINavigationController(rootViewController: BasketRouter.createModule())
        let viewController = view as! MainTabBarController
        viewController.present(basketNavigationController, animated: true)
    }
}
