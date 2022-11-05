//
//  SplashViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 30.10.2022.
//

import UIKit

final class SplashViewController: UIViewController, AlertPresentable {
    //MARK: - Properties
    private let splashView = SplashView()
    var presenter: ViewToPresenterSplashProtocol?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = splashView
        navigationItem.hidesBackButton = true
        presenter?.getCategories()
        presenter?.getProducts()
    }
}

//MARK: - PresenterToViewSplashProtocol
extension SplashViewController: PresenterToViewSplashProtocol {
    func didErrorOccurred(_ error: Error) {
        showError(error)
    }
    
    func didGetProducts() {
        presenter?.getUserDefaults()
    }
    
    func didGetUserDefaults() {
        splashView.hideSpinner()
    }
}
