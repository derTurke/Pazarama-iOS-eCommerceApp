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
        let viewController = SplashViewController()
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
        self.window = window
    }
}

