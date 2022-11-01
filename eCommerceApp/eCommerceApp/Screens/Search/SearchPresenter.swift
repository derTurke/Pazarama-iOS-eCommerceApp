//
//  SearchPresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import Foundation

final class SearchPresenter: ViewToPresenterSearchProtocol {
    weak var view: PresenterToViewSearchProtocol?
    
    var interactor: PresenterToInteractorSearchProtocol?
    
    var router: PresenterToRouterSearchProtocol?
    
    
}

extension SearchPresenter: InteractorToPresenterSearchProtocol {
    func didErrorOccurred(_ error: Error) {
        
    }
    
    
}
