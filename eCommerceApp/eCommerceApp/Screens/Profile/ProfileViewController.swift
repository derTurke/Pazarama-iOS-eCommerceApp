//
//  ProfileViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 3.11.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

final class ProfileViewController: UIViewController, AlertPresentable {
    //MARK: - Properties
    private let profileView = ProfileView()
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view = profileView
        profileView.delegate = self
        getUser()
    }
    // MARK: - Methods
    private func userSignOut() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.removeObject(forKey: "uid")
            self.tabBarController?.navigationController?.pushViewController(AuthRouter.createModule(), animated: true)
        } catch {
            self.showError(error)
        }
    }
    
    private func getUser() {
        let db = Firestore.firestore()
        guard let uid = UserDefaults.standard.string(forKey: "uid") else {
            return
        }
        db.collection("users").document(uid).getDocument { querySnapshot, error in
            if let error {
                self.showError(error)
                return
            }
            guard let data = querySnapshot?.data() else {
                return
            }
            print(data)
            self.profileView.user = User(from: data)
        }
    }
}

//MARK: - ProfileViewDelegate
extension ProfileViewController: ProfileViewDelegate {
    func signOut() {
        showAlert(title: "Sign Out", message: "Are you sure you want to sign out?", cancelButtonTitle: "Cancel") { _ in
            self.userSignOut()
        }
    }
}


