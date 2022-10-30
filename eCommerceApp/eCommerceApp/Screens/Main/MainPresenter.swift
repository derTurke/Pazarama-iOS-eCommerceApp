//
//  MainPresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import Foundation
import UIKit

final class MainPresenter: ViewToPresenterMainProtocol {
    
    weak var view: PresenterToViewMainProtocol?
    
    var interactor: PresenterToInteractorMainProtocol?
    
    var router: PresenterToRouterMainProtocol?
    
    var products: [Products]? {
        didSet {
            numberOfItemsInSection = products?.count
        }
    }
    
    var numberOfItemsInSection: Int?
    
    func getProducts() {
        interactor?.fetchProducts()
    }
    
    func productForIndexPath(_ indexPath: IndexPath) -> Products? {
        products?[indexPath.row]
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

extension MainPresenter: InteractorToPresenterMainProtocol {
    func didErrorOccurred(_ error: Error) {
        view?.didErrorOccurred(error)
    }
    
    func didFetchProducts(_ products: [Products]) {
        self.products = products
        view?.didGetProducts()
    }
}
