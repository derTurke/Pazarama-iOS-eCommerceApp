//
//  SplashView.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 30.10.2022.
//

import UIKit

final class SplashView: UIView {
    //MARK: - Properties
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon")
        return imageView
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.text = "eCommerce"
        label.font = UIFont(name: "Helvetica-bold", size: 24)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "primary")
        return label
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .whiteLarge
        spinner.color = UIColor(named: "primary")
        spinner.startAnimating()
        return spinner
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "background")
        setupSplashView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupSplashView() {
        setupIcon()
        setupBrandLabel()
        setupSpinner()
    }
    
    private func setupIcon() {
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 128.0),
            iconImageView.heightAnchor.constraint(equalToConstant: 128.0)
        ])
    }
    
    private func setupBrandLabel() {
        addSubview(brandLabel)
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            brandLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            brandLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 15)
        ])
    }
    
    private func setupSpinner() {
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinner.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 15)
        ])
    }
    
    func hideSpinner() {
        spinner.stopAnimating()
        spinner.hidesWhenStopped = true
    }
}
