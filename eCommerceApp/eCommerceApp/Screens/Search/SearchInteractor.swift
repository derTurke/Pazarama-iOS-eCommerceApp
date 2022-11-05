//
//  SearchInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import Foundation
import FirebaseFirestore

final class SearchInteractor: PresenterToInteractorSearchProtocol {
    var presenter: InteractorToPresenterSearchProtocol?
    
    var product: Products?
    
    private let db = Firestore.firestore()
    
    func fetchProductSearch(_ text: String?, withCategory category: String?) {
        guard let text = text,
              let category = category else {
            return
        }
        db.collection("products").getDocuments() { querySnapshot, error in
            if let error {
                self.presenter?.didErrorOccurred(error)
                return
            }
            guard let documents = querySnapshot?.documents else {
                return
            }
            
            var products = [Products]()
            documents.forEach { document in
                products.append(Products(from: document.data()))
            }
            
            products = products.filter({ product in
                guard let productTitle = product.title,
                      let categoryTitle = product.category else {
                    return false
                }
                if category == "All" {
                    return productTitle.lowercased().contains(text.lowercased())
                } else {
                    return (productTitle.lowercased().contains(text.lowercased()) &&
                    categoryTitle.lowercased().contains(category.lowercased()))
                }
            })
            
            self.presenter?.didFetchProductSearch(products)
        }
    }
    
    func fetchCategories() {
        db.collection("categories").getDocuments() { querySnapshot, error in
            if let error {
                self.presenter?.didErrorOccurred(error)
                return
            }
            guard let documents = querySnapshot?.documents else {
                return
            }
            var categories = [Category]()
            documents.forEach { document in
                categories.append(Category(from: document.data()))
            }
            self.categoryToString(categories)
        }
    }
    
    func categoryToString(_ categories: [Category]?) {
        guard let categories = categories else { return }
        var stringCategory = [String]()
        stringCategory.append("All")
        categories.forEach { category in
            guard let name = category.name else { return }
            stringCategory.append(name)
        }
        self.presenter?.didFetchCategories(stringCategory)
    }
}

