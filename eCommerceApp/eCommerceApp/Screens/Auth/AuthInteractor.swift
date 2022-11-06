//
//  AuthInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class AuthInteractor: PresenterToInteractorAuthProtocol {
    // MARK: Properties
    weak var presenter: InteractorToPresenterAuthProtocol?
    
    var handle: AuthStateDidChangeListenerHandle?
    private let db = Firestore.firestore()
    private let defaults = UserDefaults.standard
    
    //MARK: - Methods
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                self.presenter?.didErrorOccurred(error)
                return
            }
            guard let id = result?.user.uid else { return }
            self.defaults.set(id, forKey: "uid")
            self.presenter?.didAuthSuccess()
        }
    }
    
    func createUser(username: String, email: String, password: String, passwordAgain: String) {
        if username.isEmpty {
            self.presenter?.didErrorOccurred(AuthError.emptyUsername)
            return
        }
        if email.isEmpty {
            self.presenter?.didErrorOccurred(AuthError.emptyEmail)
            return
        }
        if password.isEmpty {
            self.presenter?.didErrorOccurred(AuthError.emptyPassword)
            return
        }
        if passwordAgain != password {
            self.presenter?.didErrorOccurred(AuthError.doesNotMatchPassword)
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error {
                self.presenter?.didErrorOccurred(error)
                return
            }
            guard let id = result?.user.uid else { return }
            let user = User(uid: id, username: username, email: email, password: password, passwordAgain: passwordAgain)
            self.saveUserInformation(user)
            
        }
    }
    
    func saveUserInformation(_ user: User?) {
        guard let user = user,
              let uid = user.uid else { return }
        do {
            guard let data = try user.dictionary else {
                return
            }
            db.collection("users").document(uid).setData(data) { error in
                if let error {
                    self.presenter?.didErrorOccurred(error)
                    return
                }
                self.defaults.set(uid, forKey: "uid")
                self.presenter?.didAuthSuccess()
            }
        } catch {
            self.presenter?.didErrorOccurred(error)
        }
    }
    
    func addStateDidChangeListener() {
        handle = Auth.auth().addStateDidChangeListener{ auth, user in }
    }
    
    func removeStateDidChangeListener() {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
}
