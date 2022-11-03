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

    private let viewModel: MainTabBarViewModel
    
    //MARK: - Init
    init(viewModel: MainTabBarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        getTotalPrice()
        let notificationCenter: NotificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(getTotalPrice), name: .getBasketTotalPrice, object: nil)
        setupView()
    }
    
    //MARK: - Methods
    @objc private func getTotalPrice() {
        viewModel.fetchBasketTotalPrice()
        
    }
    
    @objc private func didTapBasket() {
        let basketNavigationController = UINavigationController(rootViewController: BasketRouter.createModule())
        present(basketNavigationController, animated: true)
    }
    
    private func setupView() {
        barButtonItem.customView = button
        tabBarConfigure()
        setupTabBarController()
    }
    
    func setupTabBarController() {
        //Recent View Tab
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
        let nav3 = setupViewController(with: UIViewController(),
                                       tabBarTitle: "Profile",
                                       tabBarImage: UIImage(named: "user")!,
                                       tabBarSelectedImage: nil,
                                       barButtonItem: barButtonItem)
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
    
    func setupViewController(with viewController: UIViewController,
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
    
    private func tabBarConfigure() {
        UITabBar.appearance().tintColor = UIColor(named: "primary")
        UITabBar.appearance().backgroundColor = UIColor(named: "background-2")
    }
    
}

//MARK: - MainTabBarDelegate
extension  MainTabBarController: MainTabBarDelegate {
    func didErrorOccurred(_ error: Error) {
        showError(error)
    }
    
    func didFetchTotalPrice(_ totalPrice: Double) {
        button.setTitle("\(totalPrice.priceFormatted)", for: .normal)
    }
}
