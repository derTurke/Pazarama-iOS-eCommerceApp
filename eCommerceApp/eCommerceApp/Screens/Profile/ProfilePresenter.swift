//
//  ProfilePresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 5.11.2022.
//

import UIKit

final class ProfilePresenter: ViewToPresenterProfileProtocol {
    weak var view: PresenterToViewProfileProtocol?
    var interactor: PresenterToInteractorProfileProtocol?
    var router: PresenterToRouterProfileProtocol?
    
    func getUserInformation() {
        interactor?.fetchUserInformation()
    }
    
    func signOut() {
        interactor?.signOut()
    }
    
    func saveImagePicker(image: UIImage?) {
        guard let imageData = image?.pngData() else {
            return
        }
        interactor?.saveImagePicker(imageData)
    }
    
    func getProfilePicture() {
        interactor?.fetchProfilePicture()
    }
}

extension ProfilePresenter: InteractorToPresenterProfileProtocol {
    func didErrorOccurred(_ error: Error) {
        view?.didErrorOccurred(error)
    }
    
    func didFetchUser(_ user: User?) {
        view?.didGetUser(user)
    }
    
    func signOutSuccess() {
        router?.pushToAuth(on: view!)
    }
    
    func didFetchImage(_ url: URL?) {
        guard let url = url else { return }
        view?.didGetImage(url)
    }
}
