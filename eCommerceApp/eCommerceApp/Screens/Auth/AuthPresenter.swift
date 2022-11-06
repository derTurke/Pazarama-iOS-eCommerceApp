//
//  AuthPresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import Foundation

final class AuthPresenter: ViewToPresenterAuthProtocol {
    // MARK: Properties
    weak var view: PresenterToViewAuthProtocol?
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
                               passwordAgain: passwordAgain)
    }
    
    func addStateDidChangeListener() {
        interactor?.addStateDidChangeListener()
    }
    
    func removeStateDidChangeListener() {
        interactor?.removeStateDidChangeListener()
    }
}

extension AuthPresenter: InteractorToPresenterAuthProtocol {
    func didErrorOccurred(_ error: Error) {
        view?.didErrorOccurred(error)
    }
    
    func didAuthSuccess() {
        router?.pushToMain(on: view!)
    }
}
