//
//  ProfileInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 5.11.2022.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

final class ProfileInteractor: PresenterToInteractorProfileProtocol {
    weak var presenter: InteractorToPresenterProfileProtocol?
    
    private let db = Firestore.firestore()
    private let defaults = UserDefaults.standard
    private let ref = Storage.storage().reference()
    
    func fetchUserInformation() {
        guard let uid = defaults.string(forKey: "uid") else {
            return
        }
        db.collection("users").document(uid).getDocument { querySnapshot, error in
            if let error {
                self.presenter?.didErrorOccurred(error)
                return
            }
            guard let data = querySnapshot?.data() else {
                return
            }
            let user = User(from: data)
            self.presenter?.didFetchUser(user)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            defaults.removeObject(forKey: "uid")
            self.presenter?.signOutSuccess()
        } catch {
            self.presenter?.didErrorOccurred(error)
        }
    }
    
    func saveImagePicker(_ data: Data) {
        guard let uid = defaults.string(forKey: "uid") else {
            return
        }
        ref.child("images/\(uid).png").putData(data) {_, error in
            if let error {
                self.presenter?.didErrorOccurred(error)
                return
            }
            self.fetchProfilePicture()
        }
    }
    
    func fetchProfilePicture() {
        guard let uid = defaults.string(forKey: "uid") else { return }
        ref.child("images/\(uid).png").downloadURL { url, error in
            guard let url = url else {
                return
            }
            if let error {
                self.presenter?.didErrorOccurred(error)
            }
            self.presenter?.didFetchImage(url.absoluteURL)
        }
    }
}
