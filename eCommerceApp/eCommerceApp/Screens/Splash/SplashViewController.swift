//
//  SplashViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 30.10.2022.
//

import UIKit

final class SplashViewController: UIViewController {
    //MARK: - Properties
    private let splashView = SplashView()
    //MARK: - Init
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = splashView
        navigationItem.hidesBackButton = true
    }
    //MARK: - Methods
}
