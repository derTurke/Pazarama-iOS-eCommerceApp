//
//  SearchView.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import UIKit

final class SearchView: UIView {
    //MARK: - Properties
    let searchController = UISearchController()
    let segmentedController: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        return segmentedControl
    }()
    let segementBarItem = UIBarButtonItem()
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "background")
        searchController.searchBar.showsScopeBar = true
        searchController.searchBar.scopeBarButtonTitleTextAttributes(for: .application)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupCollectionView() {
        addSubview(collectionView)
        collectionView.backgroundColor = UIColor(named: "background")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func setCollectionViewDelegate(_ delegate: UICollectionViewDelegate,
                                   andDataSource dataSource: UICollectionViewDataSource) {
        collectionView.delegate = delegate
        collectionView.dataSource = dataSource
    }
    
    func refresh() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func setScopeButtonTitles(_ categories: [String]) {
        searchController.searchBar.scopeButtonTitles = categories
    }
}
