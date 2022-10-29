//
//  AuthContract.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import Foundation
import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewAuthProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didAuthSuccess()
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterAuthProtocol {
    var view: PresenterToViewAuthProtocol? { get set }
    var interactor: PresenterToInteractorAuthProtocol? { get set }
    var router: PresenterToRouterAuthProtocol? { get set }
    
    func signIn(email: String, password: String)
    func signUp(username: String, email: String, password: String, passwordAgain: String)
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAuthProtocol {
    var presenter: InteractorToPresenterAuthProtocol? { get set }
    
    func loginUser(email: String, password: String)
    func createUser(username: String, email: String, password: String, passwordAgain: String)
    func saveUserInformation(_ user: User?)
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterAuthProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didAuthSuccess()
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterAuthProtocol {
    static func createModule() -> UIViewController
}
