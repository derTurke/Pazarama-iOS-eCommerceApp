//
//  MainTabBarController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarConfigure()
        setupTabBarController()
    }
    //MARK: - Methods
    
    private func setupTabBarController() {
        //Recent View Tab
        let nav1 = setupViewController(with: UIViewController(),
                                       tabBarTitle: "Recent",
                                       tabBarImage: UIImage(named: "home")!,
                                       tabBarSelectedImage: nil)
        //Search View Tab
        let nav2 = setupViewController(with: UIViewController(),
                                       tabBarTitle: "Search",
                                       tabBarImage: UIImage(named: "search")!,
                                       tabBarSelectedImage: nil)
        //Profile View Tab
        let nav3 = setupViewController(with: UIViewController(),
                                       tabBarTitle: "Profile",
                                       tabBarImage: UIImage(named: "user")!,
                                       tabBarSelectedImage: nil)
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
    
    //MARK: - Setup TabBarViewController
    private func setupViewController(with viewController: UIViewController, tabBarTitle: String, tabBarImage: UIImage, tabBarSelectedImage: UIImage?) -> UINavigationController {
        viewController.tabBarItem = UITabBarItem(title: tabBarTitle,
                                                 image: tabBarImage,
                                                 selectedImage: tabBarSelectedImage)
        return UINavigationController(rootViewController: viewController)
    }
    
    //MARK: - Setup TabBar Configure
    private func tabBarConfigure() {
        UITabBar.appearance().tintColor = UIColor(named: "primary")
        UITabBar.appearance().backgroundColor = UIColor(named: "background-2")
    }
}
