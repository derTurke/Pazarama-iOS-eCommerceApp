//
//  DimmedPresentable.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 2.11.2022.
//

import UIKit

protocol DimmedPresentable {}

extension DimmedPresentable where Self: UIViewController {
    func dimmed(isShow: Bool) {
        let spinner = spinner()
        let dimmedView = dimmedView()
        
        setupSpinner(spinner, andDimmedView: dimmedView)
        
        if isShow {
            UIView.animate(withDuration: 0.3) {
                dimmedView.alpha = 0.7
                spinner.startAnimating()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                dimmedView.alpha = 0.0
                spinner.stopAnimating()
                spinner.hidesWhenStopped = true
            }
        }
        
        
    }
    
    private func spinner() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView()
        spinner.style = .whiteLarge
        spinner.color = UIColor(named: "primary")
        return spinner
    }
    
    private func dimmedView() -> UIView {
        let dimmedView = UIView()
        dimmedView.backgroundColor = .black
        dimmedView.alpha = 0.0
        return dimmedView
    }
    
    private func setupSpinner(_ spinner: UIActivityIndicatorView, andDimmedView dimmedView: UIView) {
        view.addSubview(dimmedView)
        dimmedView.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dimmedView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: dimmedView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: dimmedView.centerYAnchor)
        ])
    }
}
