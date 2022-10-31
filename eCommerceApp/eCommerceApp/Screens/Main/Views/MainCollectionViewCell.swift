//
//  MainCollectionViewCell.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 29.10.2022.
//

import UIKit
import Kingfisher

final class MainCollectionViewCell: UICollectionViewCell {
    //MARK: - Properties
    
    var product: Products? {
        didSet {
            guard let product = product, let price = product.price else {
                return
            }
            guard let url = URL(string: product.image ?? "") else {
                return
            }
            imageView.kf.setImage(with: url)
            productName.text = product.title
            productPrice.text = "$\(price)"
        }
    }
    
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let productName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-bold", size: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-bold", size: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViewCell()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupCollectionViewCell() {
        setupContentView()
        setupImageView()
        setupProductName()
        setupProductPrice()
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowRadius = 12
    }
    
    private func setupImageView() {
        let imageViewHeight = CGFloat(contentView.frame.height * 0.5)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            imageView.heightAnchor.constraint(equalToConstant: imageViewHeight)
        ])
    }
    
    private func setupProductName() {
        addSubview(productName)
        productName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            productName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            productName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0)
        ])
    }
    
    private func setupProductPrice() {
        addSubview(productPrice)
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productPrice.topAnchor.constraint(equalTo: productName.bottomAnchor, constant: 15),
            productPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10.0),
            productPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10.0)
        ])
    }
}
