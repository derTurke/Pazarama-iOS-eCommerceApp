//
//  MainViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import UIKit
import Kingfisher

final class MainViewController: UIViewController, AlertPresentable {
    //MARK: - Properties
    private let mainView = MainView()
    var presenter: ViewToPresenterMainProtocol!
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        view = mainView
        mainView.setCollectionViewDelegate(with: self, andDataSource: self)
        tabBarController?.navigationController?.isNavigationBarHidden = true
        getProducts()
    }
    //MARK: - Methods
    private func getProducts() {
        presenter.getProducts()
    }
}

//MARK: - PresenterToViewMainProtocol
extension MainViewController: PresenterToViewMainProtocol {
    func didErrorOccurred(_ error: Error) {
        showError(error)
    }
    
    func didGetProducts() {
        mainView.refresh()
    }
}

//MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItemAt(indexPath)
    }
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MainCollectionViewCell else {
            fatalError("MainCollectionViewCell not found.")
        }
        cell.product = presenter.productForIndexPath(indexPath)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
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
