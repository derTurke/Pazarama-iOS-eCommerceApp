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
    var presenter: ViewToPresenterMainProtocol?
    //MARK: - Init
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
        presenter?.getProducts()
    }
}

//MARK: -
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
    
}

//MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.numberOfItemsInSection ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MainCollectionViewCell else {
            fatalError("MainCollectionViewCell not found.")
        }
        guard let product = presenter?.productForIndexPath(indexPath) else {
            return cell
        }
        guard let url = URL(string: product.image ?? "") else {
            return cell
        }
        cell.imageView.kf.setImage(with: url)
        cell.name = product.title
        cell.price = product.price
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        presenter?.insetForSectionAt() ?? UIEdgeInsets()
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        presenter?.sizeForItemAt(with: view) ?? CGSize()
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        presenter?.minimumLineSpacingForSectionAt() ?? CGFloat()
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        presenter?.minimumInteritemSpacingForSectionAt() ?? CGFloat()
    }
}
