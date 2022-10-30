//
//  SplashRouter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 30.10.2022.
//

import Foundation
import UIKit

final class SplashRouter: PresenterToRouterSplashProtocol {
    static func createModule() -> UIViewController {
        let viewController = SplashViewController()
        let presenter: ViewToPresenterSplashProtocol & InteractorToPresenterSplashProtocol = SplashPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = SplashRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = SplashInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
}
