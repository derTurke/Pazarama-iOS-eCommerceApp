//
//  MainTabBarContract.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 5.11.2022.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewMainTabBarProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didGetBasketTotalPrice(_ totalPrice: Double)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMainTabBarProtocol {
    var view: PresenterToViewMainTabBarProtocol? { get set }
    var interactor: PresenterToInteractorMainTabBarProtocol? { get set }
    var router: PresenterToRouterMainTabBarProtocol? { get set }
    var totalPrice: Double? { get set }
    
    func getBasketTotalPrice()
    func presentBasket()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMainTabBarProtocol {
    var presenter: InteractorToPresenterMainTabBarProtocol? { get set }
    
    func fetchBasketTotalPrice()
    func calcTotalPrice(with basket: [Basket]?)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMainTabBarProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didFetchBasketTotalPrice(_ totalPrice: Double?)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMainTabBarProtocol {
    static func createModule() -> UITabBarController
    func presentBasket(on view: PresenterToViewMainTabBarProtocol)
}
