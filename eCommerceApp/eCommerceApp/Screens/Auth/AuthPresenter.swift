//
//  AuthPresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import Foundation

final class AuthPresenter: ViewToPresenterAuthProtocol {
    // MARK: Properties
    var view: PresenterToViewAuthProtocol?
    var interactor: PresenterToInteractorAuthProtocol?
    var router: PresenterToRouterAuthProtocol?
    
    //MARK: - Methods
    func signIn(email: String, password: String) {
        interactor?.loginUser(email: email, password: password)
    }
    
    func signUp(username: String, email: String, password: String, passwordAgain: String) {
        interactor?.createUser(username: username,
                               email: email,
                               password: password,
                               passwordAgain: password)
    }
    
}

extension AuthPresenter: InteractorToPresenterAuthProtocol {
    func didErrorOccurred(_ error: Error) {
        view?.didErrorOccurred(error)
    }
    
    func didSuccess() {
        view?.didSuccess()
    }
}
