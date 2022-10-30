//
//  MainInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import Foundation
import FirebaseFirestore

final class MainInteractor: PresenterToInteractorMainProtocol {
    weak var presenter: InteractorToPresenterMainProtocol?
    
    private let db = Firestore.firestore()
    
    func fetchProducts() {
        db.collection("products").getDocuments() { error in
            if let error {
                
                return
            }
        }
    }
}
