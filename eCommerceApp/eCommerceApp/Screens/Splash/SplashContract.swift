//
//  SplashContract.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 30.10.2022.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewSplashProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didGetProducts()
    func didGetUserDefaults()
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSplashProtocol {
    var view: PresenterToViewSplashProtocol? { get set }
    var interactor: PresenterToInteractorSplashProtocol? { get set }
    var router: PresenterToRouterSplashProtocol? { get set }
    
    func getProducts()
    func getCategories()
    func getUserDefaults()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSplashProtocol {
    var presenter: InteractorToPresenterSplashProtocol? { get set }
    
    func fetchProducts()
    func addProductsToFirebaseFirestore(_ products: [Products]?)
    func fetchCategories()
    func addCategoriesToFirebaseFirestore(_ categories: [Category]?)
    func fetchUserDefaults()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSplashProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didFetchProducts()
    func didFetchUserDefaults(with viewController: UIViewController)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSplashProtocol {
    static func createModule() -> UIViewController
    func pushToProductDetail(on view: PresenterToViewSplashProtocol, with pushViewController: UIViewController)
}
