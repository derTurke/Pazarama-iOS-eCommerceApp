//
//  OnboardingRouter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 5.11.2022.
//

import UIKit

final class OnboardingRouter: PresenterToRouterOnboardingProtocol {
    static func createModule() -> UIViewController {
        let viewController = OnboardingViewController()
        let presenter: ViewToPresenterOnboardingProtocol & InteractorToPresenterOnboardingProtocol = OnboardingPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = OnboardingRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = OnboardingInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    func pushToAuth(on view: PresenterToViewOnboardingProtocol) {
        let authViewController = AuthRouter.createModule()
        let viewController = view as! OnboardingViewController
        viewController.navigationController?.pushViewController(authViewController, animated: true)
    }
}
