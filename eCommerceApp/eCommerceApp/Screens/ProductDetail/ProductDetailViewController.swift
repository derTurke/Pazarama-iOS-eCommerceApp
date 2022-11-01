//
//  ProductDetailViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 31.10.2022.
//

import UIKit

final class ProductDetailViewController: UIViewController, AlertPresentable {
    //MARK: - Properties
    private let productDetailView = ProductDetailView()
    var presenter: ViewToPresenterProductDetailProtocol!
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view = productDetailView
        productDetailView.delegate = self
        presenter.getProduct()
    }
    
    //MARK: - Methods
}

//MARK: - ProductDetailViewDelegate
extension ProductDetailViewController: ProductDetailViewDelegate {
    func didTapDismiss() {
        presenter.viewDismiss()
    }
    func didTapAddBasket(_ product: Products?, piece: Int?) {
        presenter.addBasket(product, piece: piece)
    }
    func didTapStepper(_ product: Products?, piece: Double?) {
        presenter.updatePriceAndPieceLabel(product, piece: piece)
    }
}

//MARK: - PresenterToViewProductDetailProtocol
extension ProductDetailViewController: PresenterToViewProductDetailProtocol {
    func didErrorOccurred(_ error: Error) {
        showError(error)
    }
    
    func didGetProduct(_ product: Products) {
        productDetailView.product = product
    }
    func didAddBasket() {
        showAlert(title: "Success", message: "Product has been added to basket.")
    }
    
    func didUpdatePriceAndPieceLabel(price: Double, piece: Int) {
        productDetailView.reloadStepper(price: price, piece: piece)
    }
    
}

