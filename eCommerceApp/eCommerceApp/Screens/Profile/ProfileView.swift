//
//  ProfileView.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 3.11.2022.
//

import UIKit

final class ProfileView: UIView {
    //MARK: - Properties
    weak var delegate: ProfileViewDelegate?
    var user: User? {
        didSet {
            guard let user = user else { return }
            usernameLabel.text = user.username
            emailLabel.text = user.email
        }
    }
    
    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-bold", size: 18)
        label.numberOfLines = 0
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-bold", size: 18)
        label.numberOfLines = 0
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Out", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapSignOut), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "background")
        setupInformationStackView()
        setupSignOutButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupInformationStackView() {
        addSubview(informationStackView)
        informationStackView.addArrangedSubview(usernameLabel)
        informationStackView.addArrangedSubview(emailLabel)
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            informationStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            informationStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
        ])
    }
    
    private func setupSignOutButton() {
        addSubview(signOutButton)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signOutButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16.0),
            signOutButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            signOutButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            signOutButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    
    @objc private func didTapSignOut() {
        delegate?.signOut()
    }
}
