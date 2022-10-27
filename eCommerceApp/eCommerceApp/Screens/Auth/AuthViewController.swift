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

final class AuthViewController: UIViewController, AlertPresentable {
    //MARK: - Properties
    private let signInView = SignInView()
    private let signUpView = SignUpView()
    var presenter: ViewToPresenterAuthProtocol?
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

extension AuthViewController: PresenterToViewAuthProtocol {
    func didErrorOccurred(_ error: Error) {
        showError(error)
    }
    
    func didSuccess() {
        
    }
}

//MARK: - SignInViewDelegate
extension AuthViewController: SignInViewDelegate {
    func didTapSignIn(email: String, password: String) {
        presenter?.signIn(email: email, password: password)
    }
    func didTapDontAccount() {
        UIView.animate(withDuration: 0.3) {
            self.view = self.signUpView
        }
    }
}

//MARK: - SignUpViewDelegate
extension AuthViewController: SignUpViewDelegate {
    func didTapSignUp(username: String, email: String, password: String, passwordAgain: String) {
        presenter?.signUp(username: username,
                          email: email,
                          password: password,
                          passwordAgain: passwordAgain)
    }
    func didTapDoAccount() {
        UIView.animate(withDuration: 0.3) {
            self.view = self.signInView
        }
    }
}
