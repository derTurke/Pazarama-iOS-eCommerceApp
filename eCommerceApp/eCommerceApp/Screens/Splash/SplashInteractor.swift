//
//  SplashInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 30.10.2022.
//

import Foundation
import eCommerceAppAPI
import FirebaseFirestore


final class SplashInteractor: PresenterToInteractorSplashProtocol {
    
    
    //MARK: - Properties
    weak var presenter: InteractorToPresenterSplashProtocol?
    
    private let defaults = UserDefaults.standard
    private let db = Firestore.firestore()
    
    //MARK: - Methods
    func fetchProducts() {
        fakeStoreProvider.request(.getProducts) { result in
            switch result {
                case .success(let response):
                    do {
                        let products = try JSONDecoder().decode([Products].self, from: response.data)
                        self.addProductsToFirebaseFirestore(products)
                        self.presenter?.didFetchProducts()
                    } catch {
                        self.presenter?.didErrorOccurred(error)
                    }
                case .failure(let error):
                    self.presenter?.didErrorOccurred(error)
            }
        }
    }
    
    func addProductsToFirebaseFirestore(_ products: [Products]?) {
        guard let products = products else {
            return
        }
        for product in products {
            guard let productId = product.id else { return }
            do {
                guard let data = try product.dictionary else { return }
                self.db.collection("products").document("\(productId)").setData(data) { error in
                    if let error {
                        self.presenter?.didErrorOccurred(error)
                        return
                    }
                }
            } catch {
                self.presenter?.didErrorOccurred(error)
            }
        }
        
    }
    
    func fetchUserDefaults() {
        if defaults.integer(forKey: "skipOnboarding") == 1 {
            presenter?.didFetchUserDefaults(with: AuthRouter.createModule())
        } else if defaults.string(forKey: "uid") != nil {
            presenter?.didFetchUserDefaults(with: MainTabBarController())
        } else {
            presenter?.didFetchUserDefaults(with: OnboardingViewController())
        }
    }
}
