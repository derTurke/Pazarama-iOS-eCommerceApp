//
//  ProfileRouter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 5.11.2022.
//

import UIKit

final class ProfileRouter: PresenterToRouterProfileProtocol {
    static func createModule() -> UIViewController {
        let viewController = ProfileViewController()
        let presenter: ViewToPresenterProfileProtocol & InteractorToPresenterProfileProtocol = ProfilePresenter()
        viewController.presenter = presenter
        viewController.presenter.router = ProfileRouter()
        viewController.presenter.view = viewController
        viewController.presenter.interactor = ProfileInteractor()
        viewController.presenter.interactor?.presenter = presenter
        return viewController
    }
    
    func pushToAuth(on view: PresenterToViewProfileProtocol) {
        let authViewController = AuthRouter.createModule()
        let viewController = view as! ProfileViewController
        viewController.tabBarController?.navigationController?.pushViewController(authViewController, animated: true)
    }
}
