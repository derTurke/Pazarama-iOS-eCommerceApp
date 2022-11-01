//
//  SearchViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import UIKit

final class SearchViewController: UIViewController {
    //MARK: - Properties
    private let searchView = SearchView()
    var presenter: ViewToPresenterSearchProtocol!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view = searchView
    }
    //MARK: - Methods
}

extension SearchViewController: PresenterToViewSearchProtocol {
    func didErrorOccurred(_ error: Error) {
        
    }
}
