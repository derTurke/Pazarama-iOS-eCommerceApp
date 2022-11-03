//
//  BasketViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 2.11.2022.
//

import UIKit

final class BasketViewController: UIViewController, AlertPresentable {
    //MARK: - Properties
    private let basketView = BasketView()
    var presenter: ViewToPresenterBasketProtocol!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Basket"
        view = basketView
        basketView.delegate = self
        basketView.setTableViewDelegate(self, andDataSource: self)
        getBasket()
    }
    
    //MARK: - Properties
    private func getBasket() {
        presenter.getBasket()
    }
}

//MARK: - BasketViewDelegate
extension BasketViewController: BasketViewDelegate {
    func didTapBuyButton() {
        showAlert(title: "Pay",
                  message: "Do you want to complete the purchase?",
                  cancelButtonTitle: "Cancel") { _ in
            self.presenter.buyBasket()
        }
    }
}

//MARK: - BasketTableViewCellDelegate
extension BasketViewController: BasketTableViewCellDelegate {
    func didTapStepper(_ basket: Basket?, piece: Double?) {
        presenter.updateBasket(basket, piece: piece)
    }
    
    func didTapDeleteButton(_ basket: Basket?) {
        showActionSheet(message: "Are you sure you want to remove the product from the cart?",
                        buttonTitle: "Delete",
                        style: .destructive) { _ in
            self.presenter.deleteProduct(basket)
        }
    }
}

//MARK: - PresenterToViewBasketProtocol
extension BasketViewController: PresenterToViewBasketProtocol {
    func didErrorOccurred(_ error: Error) {
        showError(error)
    }
    
    func didGetBasket() {
        basketView.reloadTableView()
    }
    
    func didGetTotalPrice(_ totalPrice: Double) {
        basketView.reloadTotalPrice(totalPrice)
    }
    
    func didBuyBasket() {
        showAlert(title: "Success", message: "Your order has been received. We thank you.") { _ in
            self.presenter.router?.dismiss(on: self.presenter.view!)
        }
    }
}

//MARK: - UITableViewDelegate
extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        presenter.heightForRowAt()
    }
}

//MARK: - UITableViewDataSource
extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BasketTableViewCell else {
            fatalError("BasketTableViewCell not found")
        }
        cell.basket = presenter.productForIndexPath(indexPath)
        cell.delegate = self
        return cell
    }
}
