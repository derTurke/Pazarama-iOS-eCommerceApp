//
//  ProductRouter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 31.10.2022.
//

import UIKit

final class ProductDetailRouter: PresenterToRouterProductDetailProtocol {
    static func createModule(_ product: Products) -> UIViewController {
        let viewController = ProductDetailViewController()
        let presenter: ViewToPresenterProductDetailProtocol & InteractorToPresenterProductDetailProtocol = ProductDetailPresenter()
        viewController.presenter = presenter
        viewController.presenter.router = ProductDetailRouter()
        viewController.presenter.view = viewController
        viewController.presenter.interactor = ProductDetailInteractor()
        viewController.presenter.interactor?.presenter = presenter
        viewController.presenter.interactor?.product = product
        return viewController
    }
    
    func dismiss(on view: PresenterToViewProductDetailProtocol) {
        let viewController = view as! ProductDetailViewController
        viewController.dismiss(animated: true)
    }
}
