//
//  MainRouter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import Foundation
import UIKit

final class MainRouter: PresenterToRouterMainProtocol {
    static func createModule() -> UIViewController {
        let viewController = MainViewController()
        let presenter: ViewToPresenterMainProtocol & InteractorToPresenterMainProtocol = MainPresenter()
        viewController.presenter = presenter
        viewController.presenter?.router = MainRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = MainInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
    func pushToProductDetail(on view: PresenterToViewMainProtocol, with product: Products) {
        let productDetailViewController = UIViewController()
        productDetailViewController.modalPresentationStyle = .fullScreen
        productDetailViewController.modalTransitionStyle = .partialCurl
        let viewController = view as! MainViewController
        viewController.present(productDetailViewController, animated: true)
    }
}
