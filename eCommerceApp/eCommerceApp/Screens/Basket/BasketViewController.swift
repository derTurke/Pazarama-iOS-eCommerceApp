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
        basketView.setTableViewDelegate(self, andDataSource: self)
    }
    
    //MARK: - Properties
}

//MARK: - PresenterToViewBasketProtocol
extension BasketViewController: PresenterToViewBasketProtocol {
    func didErrorOccurred(_ error: Error) {
        
    }
}

//MARK: - UITableViewDelegate
extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

//MARK: - UITableViewDataSource
extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? BasketTableViewCell else {
            fatalError("BasketTableViewCell not found")
        }
        return cell
    }
}
