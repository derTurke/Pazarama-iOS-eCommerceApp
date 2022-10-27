//
//  AuthRouter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import UIKit

final class AuthRouter: PresenterToRouterAuthProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        let viewController = AuthViewController()
        let presenter: ViewToPresenterAuthProtocol & InteractorToPresenterAuthProtocol = AuthPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = AuthRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = AuthInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
