//
//  ProfileViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 3.11.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class ProfileViewController: UIViewController, AlertPresentable, DimmedPresentable{
    //MARK: - Properties
    private let profileView = ProfileView()
    var presenter: ViewToPresenterProfileProtocol!
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view = profileView
        profileView.delegate = self
        getUserInformation()
        getProfilePicture()
        
    }
    //MARK: - Methods
    func getUserInformation() {
        presenter.getUserInformation()
    }
    
    func getProfilePicture() {
        presenter.getProfilePicture()
    }
}

//MARK: - PresenterToViewProfileProtocol
extension ProfileViewController: PresenterToViewProfileProtocol {
    func didErrorOccurred(_ error: Error) {
        showError(error)
    }
    
    func didGetUser(_ user: User?) {
        profileView.user = user
    }
    
    func didGetImage(_ url: URL) {
        profileView.reloadImage(url)
    }
}

//MARK: - ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    func signOut() {
        showAlert(title: "Sign Out", message: "Are you sure you want to sign out?", cancelButtonTitle: "Cancel") { _ in
            self.presenter.signOut()
        }
    }
    
    func tapImageView() {
        pickerImage()
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func pickerImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        presenter.saveImagePicker(image: image)
    }
        
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
