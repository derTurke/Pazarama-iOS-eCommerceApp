//
//  SearchPresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import UIKit

final class SearchPresenter: ViewToPresenterSearchProtocol {
    weak var view: PresenterToViewSearchProtocol?
    
    var interactor: PresenterToInteractorSearchProtocol?
    
    var router: PresenterToRouterSearchProtocol?
    
    var products: [Products]? {
        didSet {
            numberOfItemsInSection = products?.count ?? .zero
            view?.didGetProducts()
        }
    }
    
    var numberOfItemsInSection: Int = .zero
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text ,
        let category = searchController.searchBar.scopeButtonTitles?[
                                                    searchController.searchBar.selectedScopeButtonIndex] else {
            return
        }
        if text.count > 2 {
            interactor?.fetchProductSearch(text, withCategory: category)
        } else {
            self.products = []
        }
    }
    
    func getCategories() {
        interactor?.fetchCategories()
    }
    
    func didGetCategories() {
        interactor?.fetchCategories()
    }
    
    func productForIndexPath(_ indexPath: IndexPath) -> Products? {
        products?[indexPath.row]
    }
    
    func didSelectItemAt(_ indexPath: IndexPath) {
        guard let product = products?[indexPath.row] else {
            return
        }
        router?.pushToProductDetail(on: view!, with: product)
    }
    
    func insetForSectionAt() -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func sizeForItemAt(with view: UIView) -> CGSize {
        CGSize(width: (view.frame.width / 2) - 15, height: (view.frame.width / 1.25))
    }
    
    func minimumLineSpacingForSectionAt() -> CGFloat {
        10
    }
    
    func minimumInteritemSpacingForSectionAt() -> CGFloat {
        5
    }
}

extension SearchPresenter: InteractorToPresenterSearchProtocol {
    func didErrorOccurred(_ error: Error) {
        view?.didErrorOccurred(error)
    }
    
    func didFetchProductSearch(_ products: [Products]?) {
        self.products = products
    }
    
    func didFetchCategories(_ categories: [String]?) {
        guard let categories = categories else { return }
        view?.didGetCategories(categories)
    }
}
