//
//  SearchContract.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewSearchProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didGetProducts()
    func didGetCategories(_ categories: [String])
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSearchProtocol {
    var view: PresenterToViewSearchProtocol? { get set }
    var interactor: PresenterToInteractorSearchProtocol? { get set }
    var router: PresenterToRouterSearchProtocol? { get set }
    var products: [Products]? { get set }
    var numberOfItemsInSection: Int { get set }
    
    func updateSearchResults(for searchController: UISearchController)
    func getCategories()
    func productForIndexPath(_ indexPath: IndexPath) -> Products?
    func didSelectItemAt(_ indexPath: IndexPath)
    func insetForSectionAt() -> UIEdgeInsets
    func sizeForItemAt(with view: UIView) -> CGSize
    func minimumLineSpacingForSectionAt() -> CGFloat
    func minimumInteritemSpacingForSectionAt() -> CGFloat
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSearchProtocol {
    var presenter: InteractorToPresenterSearchProtocol? { get set }
    var product: Products? {get set}
    
    func fetchProductSearch(_ text: String?, withCategory category: String?)
    func fetchCategories()
    func categoryToString(_ categories: [Category]?)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSearchProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didFetchProductSearch(_ products: [Products]?)
    func didFetchCategories(_ categories: [String]?)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSearchProtocol {
    static func createModule() -> UIViewController
    func pushToProductDetail(on view: PresenterToViewSearchProtocol, with product: Products)

}

//MARK: - Product View Delegate
protocol SearchViewDelegate: AnyObject {
}

