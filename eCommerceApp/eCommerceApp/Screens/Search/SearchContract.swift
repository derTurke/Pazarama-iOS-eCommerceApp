//
//  SearchContract.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewSearchProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSearchProtocol {
    var view: PresenterToViewSearchProtocol? { get set }
    var interactor: PresenterToInteractorSearchProtocol? { get set }
    var router: PresenterToRouterSearchProtocol? { get set }
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSearchProtocol {
    var presenter: InteractorToPresenterSearchProtocol? { get set }
    var product: Products? {get set}
    
    func fetchProduct()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSearchProtocol: AnyObject {
    func didErrorOccurred(_ error: Error)
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSearchProtocol {
    static func createModule() -> UIViewController

}

//MARK: - Product View Delegate
protocol SearchViewDelegate: AnyObject {
}

