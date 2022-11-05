//
//  SearchViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import UIKit

final class SearchViewController: UIViewController, AlertPresentable {
    //MARK: - Properties
    private let searchView = SearchView()
    var presenter: ViewToPresenterSearchProtocol!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view = searchView
        searchView.searchController.searchResultsUpdater = self
        navigationItem.searchController = searchView.searchController
        searchView.setCollectionViewDelegate(self, andDataSource: self)
        presenter.getCategories()
    }
    //MARK: - Methods
    
}

//MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.updateSearchResults(for: searchController)
    }
}

//MARK: - PresenterToViewSearchProtocol
extension SearchViewController: PresenterToViewSearchProtocol {
    func didErrorOccurred(_ error: Error) {
        showError(error)
    }
    func didGetProducts() {
        searchView.refresh()
    }
    func didGetCategories(_ categories: [String]) {
        searchView.setScopeButtonTitles(categories)
    }
}

//MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(indexPath)
    }
}

//MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MainCollectionViewCell else {
            fatalError("MainCollectionViewCell not found!")
        }
        cell.product = presenter.productForIndexPath(indexPath)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        presenter.insetForSectionAt()
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        presenter.sizeForItemAt(with: view)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        presenter.minimumLineSpacingForSectionAt()
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        presenter.minimumInteritemSpacingForSectionAt()
    }
}
