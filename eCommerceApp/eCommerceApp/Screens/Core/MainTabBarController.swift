//
//  MainTabBarController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import UIKit
import FirebaseFirestore

final class MainTabBarController: UITabBarController, AlertPresentable {
    //MARK: - Properties
    var presenter: ViewToPresenterMainTabBarProtocol!
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "basket"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-bold", size: 15)
        button.sizeToFit()
        button.addTarget(self, action: #selector(didTapBasket), for: .touchUpInside)
        return button
    }()
    private let barButtonItem = UIBarButtonItem()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getBasketTotalPriceNotification()
    }
    //MARK: - Methods
    private func getBasketTotalPriceNotification() {
        let notificationCenter: NotificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(getTotalPrice), name: .getBasketTotalPrice, object: nil)
    }
    
    @objc private func getTotalPrice() {
        presenter?.getBasketTotalPrice()
    }
    
    @objc private func didTapBasket() {
        presenter?.presentBasket()
    }
    
}

//MARK: - PresenterToViewMainTabBarProtocol
extension MainTabBarController: PresenterToViewMainTabBarProtocol {
    func didErrorOccurred(_ error: Error) {
        showError(error)
    }
    
    func didGetBasketTotalPrice(_ totalPrice: Double) {
        button.setTitle("\(totalPrice.priceFormatted)", for: .normal)
    }
}

extension MainTabBarController {
    private func setupView() {
        barButtonItem.customView = button
        setupTabBarController()
    }
    
    private func setupTabBarController() {
        //Products View Tab
        let nav1 = setupViewController(with: MainRouter.createModule(),
                                       tabBarTitle: "Home",
                                       tabBarImage: UIImage(named: "home")!,
                                       tabBarSelectedImage: nil,
                                       barButtonItem: barButtonItem)
        //Search View Tab
        let nav2 = setupViewController(with: SearchRouter.createModule(),
                                       tabBarTitle: "Search",
                                       tabBarImage: UIImage(named: "search")!,
                                       tabBarSelectedImage: nil,
                                       barButtonItem: barButtonItem)
        //Profile View Tab
        let nav3 = setupViewController(with: ProfileRouter.createModule(),
                                       tabBarTitle: "Profile",
                                       tabBarImage: UIImage(named: "user")!,
                                       tabBarSelectedImage: nil,
                                       barButtonItem: barButtonItem)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
    
    private func setupViewController(with viewController: UIViewController,
                             tabBarTitle: String,
                             tabBarImage: UIImage,
                             tabBarSelectedImage: UIImage?,
                             barButtonItem: UIBarButtonItem) -> UINavigationController {
        
        viewController.tabBarItem = UITabBarItem(title: tabBarTitle,
                                                 image: tabBarImage,
                                                 selectedImage: tabBarSelectedImage)
        
        viewController.navigationItem.rightBarButtonItem = barButtonItem
        
        return UINavigationController(rootViewController: viewController)
    }
}
