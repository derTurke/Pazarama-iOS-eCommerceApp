//
//  MainContract.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewMainProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didGetProducts()
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterMainProtocol {
    var view: PresenterToViewMainProtocol? { get set }
    var interactor: PresenterToInteractorMainProtocol? { get set }
    var router: PresenterToRouterMainProtocol? { get set }
    
    var products: [Products]? {get set}
    var numberOfItemsInSection: Int? {get set}
    
    func getProducts()
    func productForIndexPath(_ indexPath: IndexPath) -> Products?
    func insetForSectionAt() -> UIEdgeInsets
    func sizeForItemAt(with view: UIView) -> CGSize
    func minimumLineSpacingForSectionAt() -> CGFloat
    func minimumInteritemSpacingForSectionAt() -> CGFloat
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorMainProtocol {
    var presenter: InteractorToPresenterMainProtocol? { get set }
    
    func fetchProducts()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterMainProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didFetchProducts(_ products: [Products])
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterMainProtocol {
    static func createModule() -> UIViewController
}
