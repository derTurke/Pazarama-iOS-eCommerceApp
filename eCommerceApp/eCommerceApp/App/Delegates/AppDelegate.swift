//
//  AppDelegate.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupFirebase()
        setupInitialWindow()
        tabBarConfigure()
        return true
    }
    
    // Firebase setup
    private func setupFirebase() {
        FirebaseApp.configure()
        _ = Firestore.firestore()
    }
    
    //Setup Initial Window
    private func setupInitialWindow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = SplashRouter.createModule()
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        self.window = window
    }
    
    private func tabBarConfigure() {
        UITabBar.appearance().tintColor = UIColor(named: "primary")
        UITabBar.appearance().backgroundColor = UIColor(named: "background-2")
        UITabBar.appearance().barTintColor = UIColor(named: "background-2")
        UINavigationBar.appearance().barTintColor = UIColor(named: "background")
    }
}

