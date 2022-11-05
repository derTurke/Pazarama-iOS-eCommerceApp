//
//  ProfileConstract.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 3.11.2022.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewProfileProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didGetUser(_ user: User?)
    func didGetImage(_ url: URL)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterProfileProtocol {
    var view: PresenterToViewProfileProtocol? { get set }
    var interactor: PresenterToInteractorProfileProtocol? { get set }
    var router: PresenterToRouterProfileProtocol? { get set }
    
    func getUserInformation()
    func signOut()
    func saveImagePicker(image: UIImage?)
    func getProfilePicture()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorProfileProtocol {
    var presenter: InteractorToPresenterProfileProtocol? { get set }
    
    func fetchUserInformation()
    func signOut()
    func saveImagePicker(_ data: Data)
    func fetchProfilePicture()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterProfileProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
    func didFetchUser(_ user: User?)
    func signOutSuccess()
    func didFetchImage(_ url: URL?)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterProfileProtocol {
    static func createModule() -> UIViewController
    func pushToAuth(on view: PresenterToViewProfileProtocol)
}

//MARK: ProfileViewDelegate
protocol ProfileViewDelegate: AnyObject {
    func signOut()
    func tapImageView()
}


