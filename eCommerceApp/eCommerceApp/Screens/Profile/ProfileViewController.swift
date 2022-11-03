//
//  ProfileViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 3.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    //MARK: - Properties
    private let profileView = ProfileView()
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view = profileView
    }
    // MARK: - Methods

}
