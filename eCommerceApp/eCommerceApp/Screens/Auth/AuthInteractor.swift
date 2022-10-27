//
//  AuthInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import Foundation
import FirebaseAuth

final class AuthInteractor: PresenterToInteractorAuthProtocol {
    // MARK: Properties
    var presenter: InteractorToPresenterAuthProtocol?
    
    //MARK: - Methods
    func loginUser(email: String, password: String) {
        
    }
    
    func createUser(username: String, email: String, password: String, passwordAgain: String) {
        print(username)
        print(email)
        print(password)
        print(passwordAgain)
    }
}
