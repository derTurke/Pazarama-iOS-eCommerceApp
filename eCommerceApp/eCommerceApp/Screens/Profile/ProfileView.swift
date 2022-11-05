//
//  ProfileView.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 3.11.2022.
//

import UIKit
import Kingfisher

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
    
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 12
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(named: "icon")
        imageView.layer.masksToBounds = false
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor(red: 254/255, green: 205/255, blue: 112/255, alpha: 1).cgColor
        imageView.layer.borderWidth = 1.0
        imageView.image = UIImage(named: "person")
        return imageView
    }()
    
    private let editImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pencil")
        imageView.layer.masksToBounds = false
        imageView.layer.shadowRadius = 12
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.5
        return imageView
    }()
    
    private let informationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-bold", size: 16)
        label.numberOfLines = 0
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-bold", size: 16)
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
        setupCustomView()
        setupAvatarImageView()
        setupEditImageView()
        setupInformationStackView()
        setupSignOutButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupCustomView() {
        addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            customView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            customView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            customView.heightAnchor.constraint(equalToConstant: 85.0)
        ])
    }
    
    private func setupAvatarImageView() {
        //ImageView Location
        customView.addSubview(avatarImageView)
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 5.0),
            avatarImageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 10.0),
            avatarImageView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -5.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 75.0),
            avatarImageView.heightAnchor.constraint(equalToConstant: 75.0),
        ])
        
        //ImageView Tap Gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImageView))
        avatarImageView.addGestureRecognizer(tapGesture)
        
        //ImageView Setup Layer
        
        avatarImageView.backgroundColor = UIColor(named: "primary")
    }
    
    private func setupEditImageView() {
        avatarImageView.addSubview(editImageView)
        editImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editImageView.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 10.0),
            editImageView.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: -10.0),
            editImageView.widthAnchor.constraint(equalToConstant: 16.0),
            editImageView.heightAnchor.constraint(equalToConstant: 16.0),
        ])
    }
    
    private func setupInformationStackView() {
        customView.addSubview(informationStackView)
        informationStackView.addArrangedSubview(usernameLabel)
        informationStackView.addArrangedSubview(emailLabel)
        informationStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            informationStackView.topAnchor.constraint(equalTo: customView.topAnchor),
            informationStackView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5.0),
            informationStackView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10.0),
            informationStackView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -5.0)
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
    
    @objc private func didTapImageView() {
        delegate?.tapImageView()
    }
    
    func reloadImage(_ url: URL) {
        avatarImageView.kf.setImage(with: url)
    }
}
