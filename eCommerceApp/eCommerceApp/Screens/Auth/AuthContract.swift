//
//  AuthContract.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import Foundation
import UIKit
import FirebaseAuth

// MARK: View Output (Presenter -> View)
protocol PresenterToViewAuthProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterAuthProtocol {
    var view: PresenterToViewAuthProtocol? { get set }
    var interactor: PresenterToInteractorAuthProtocol? { get set }
    var router: PresenterToRouterAuthProtocol? { get set }
    
    func signIn(email: String, password: String)
    func signUp(username: String, email: String, password: String, passwordAgain: String)
    func addStateDidChangeListener()
    func removeStateDidChangeListener()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorAuthProtocol {
    var presenter: InteractorToPresenterAuthProtocol? { get set }
    var handle: AuthStateDidChangeListenerHandle? { get set }
    func loginUser(email: String, password: String)
    func createUser(username: String, email: String, password: String, passwordAgain: String)
    func saveUserInformation(_ user: User?)
    func addStateDidChangeListener()
    func removeStateDidChangeListener()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterAuthProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didAuthSuccess()
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterAuthProtocol {
    static func createModule() -> UIViewController
    func pushToMain(on view: PresenterToViewAuthProtocol)
}
