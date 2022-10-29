//
//  MainViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import UIKit

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
        // CollectionView Delegate and DataSource
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MainCollectionViewCell else {
            fatalError("MainCollectionViewCell not found.")
        }
        cell.imageView.image = UIImage(named: "icon")
        cell.name = "Bu bir deneme ürünüdür."
        cell.price = "$7.13"
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width / 2) - 15, height: (view.frame.width / 1.5))
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
}
