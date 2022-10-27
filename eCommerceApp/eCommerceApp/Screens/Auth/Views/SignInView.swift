//
//  SignInView.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import UIKit

final class SignInView: UIView {
    //MARK: - Properties
    
    weak var delegate: SignInViewDelegate?
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon")
        return imageView
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.text = "eCommerce"
        label.font = UIFont(name: "Helvetica", size: 24)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "primary")
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = UIFont(name: "Helvetica", size: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        return button
    }()
    
    private let accountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Don't you have an account?", for: .normal)
        button.setTitleColor(UIColor(named: "primary"), for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapAccount), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "background")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupView(){
        setupIconImageView()
        setupBrandLabel()
        setupSignInLabel()
        setupVerticalStackView()
        
    }
    
    private func setupIconImageView() {
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30.0),
            iconImageView.widthAnchor.constraint(equalToConstant: 128.0),
            iconImageView.heightAnchor.constraint(equalToConstant: 128.0)
        ])
    }
    
    private func setupBrandLabel() {
        addSubview(brandLabel)
        brandLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            brandLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            brandLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 15.0)
        ])
    }
    
    private func setupSignInLabel() {
        addSubview(signInLabel)
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signInLabel.topAnchor.constraint(equalTo: brandLabel.bottomAnchor, constant: 16.0),
            signInLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupVerticalStackView() {
        addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(emailTextField)
        verticalStackView.addArrangedSubview(passwordTextField)
        verticalStackView.addArrangedSubview(signInButton)
        verticalStackView.addArrangedSubview(accountButton)
        textFieldConfigure(emailTextField)
        textFieldConfigure(passwordTextField)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 16.0),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
        ])
    }
    
    
    private func textFieldConfigure(_ textField: UITextField) {
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalToConstant: 45.0)
        ])
    }
    
    @objc private func didTapSignIn() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        delegate?.didTapSignIn(email: email, password: password)
    }
    
    @objc private func didTapAccount() {
        delegate?.didTapDontAccount()
    }
}
