//
//  BasketContract.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 2.11.2022.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewBasketProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterBasketProtocol {
    var view: PresenterToViewBasketProtocol? { get set }
    var interactor: PresenterToInteractorBasketProtocol? { get set }
    var router: PresenterToRouterBasketProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorBasketProtocol {
    var presenter: InteractorToPresenterBasketProtocol? { get set }
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterBasketProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterBasketProtocol {
    static func createModule() -> UIViewController
    func dismiss(on view: PresenterToViewBasketProtocol)
}

//MARK: - Product View Delegate
protocol BasketViewDelegate: AnyObject {
    func didTapDismiss()
}
