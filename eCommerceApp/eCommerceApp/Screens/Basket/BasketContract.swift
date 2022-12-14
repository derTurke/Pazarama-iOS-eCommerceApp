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
    func didGetBasket()
    func didGetTotalPrice(_ totalPrice: Double)
    func didBuyBasket()
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterBasketProtocol {
    var view: PresenterToViewBasketProtocol? { get set }
    var interactor: PresenterToInteractorBasketProtocol? { get set }
    var router: PresenterToRouterBasketProtocol? { get set }
    
    var baskets: [Basket]? { get set }
    var numberOfRowsInSection: Int { get set }
    
    func getBasket()
    func updateBasket(_ basket: Basket?, piece: Double?)
    func buyBasket()
    func deleteProduct(_ basket: Basket?)
    func productForIndexPath(_ indexPath: IndexPath) -> Basket?
    func heightForRowAt() -> CGFloat
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorBasketProtocol {
    var presenter: InteractorToPresenterBasketProtocol? { get set }
    var totalPrice: Double? { get set }
    func fetchBasket()
    func calcTotalPrice(with baskets: [Basket]?)
    func updateBasket(_ basket: Basket?, piece: Double?)
    func paymentBasket()
    func deleteBasketsInFirestore(_ basket: Basket?)
    func deleteProductInBasket(_ basket: Basket?)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterBasketProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didFetchBasket(_ baskets: [Basket]?)
    func didFetchTotalPrice(_ totalPrice: Double?)
    func didPaymentBasket()
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterBasketProtocol {
    static func createModule() -> UIViewController
    func dismiss(on view: PresenterToViewBasketProtocol)
}

//MARK: - Product View Delegate
protocol BasketViewDelegate: AnyObject {
    func didTapBuyButton()
}

protocol BasketTableViewCellDelegate: AnyObject {
    func didTapDeleteButton(_ basket: Basket?)
    func didTapStepper(_ basket: Basket?, piece: Double?)
}
