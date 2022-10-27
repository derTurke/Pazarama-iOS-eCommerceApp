//
//  AuthViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import UIKit
protocol SignInViewDelegate: AnyObject {
    func didTapSignIn(email: String, password: String)
    func didTapDontAccount()
}

protocol SignUpViewDelegate: AnyObject {
    func didTapSignUp(username: String, email: String, password: String, passwordAgain: String)
    func didTapDoAccount()
}

final class AuthViewController: UIViewController {
    //MARK: - Properties
    private let signInView = SignInView()
    private let signUpView = SignUpView()
    //MARK: - Init
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.delegate = self
        signUpView.delegate = self
        view = signInView
        navigationItem.hidesBackButton = true
    }
}

//MARK: - SignInViewDelegate
extension AuthViewController: SignInViewDelegate {
    func didTapSignIn(email: String, password: String) {
        print(email)
    }
    func didTapDontAccount() {
        view = signUpView
    }
}

//MARK: - SignUpViewDelegate
extension AuthViewController: SignUpViewDelegate {
    func didTapSignUp(username: String, email: String, password: String, passwordAgain: String) {
        print(username)
    }
    func didTapDoAccount() {
        view = signInView
    }
}
