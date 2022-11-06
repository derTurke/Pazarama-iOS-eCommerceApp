//
//  ProductDetailContract.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 31.10.2022.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewProductDetailProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didGetProduct(_ product: Products)
    func didAddBasket()
    func didUpdatePriceAndPieceLabel(price: Double, piece: Int)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterProductDetailProtocol {
    var view: PresenterToViewProductDetailProtocol? { get set }
    var interactor: PresenterToInteractorProductDetailProtocol? { get set }
    var router: PresenterToRouterProductDetailProtocol? { get set }
    
    func viewDismiss()
    func getProduct()
    func addBasket(_ product: Products?, piece: Int?)
    func updatePriceAndPieceLabel(_ product: Products?, piece: Double?)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorProductDetailProtocol {
    var presenter: InteractorToPresenterProductDetailProtocol? { get set }
    var product: Products? {get set}
    
    func fetchProduct()
    func addBasketToFirestore(_ product: Products?, piece: Int?)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterProductDetailProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didFetchProduct(_ product: Products)
    func didAddBasketToFirestore()
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterProductDetailProtocol {
    static func createModule(_ product: Products) -> UIViewController
    func dismiss(on view: PresenterToViewProductDetailProtocol)
}

//MARK: - Product View Delegate
protocol ProductDetailViewDelegate: AnyObject {
    func didTapDismiss()
    func didTapAddBasket(_ product: Products?, piece: Int?)
    func didTapStepper(_ product: Products?, piece: Double?)
}
