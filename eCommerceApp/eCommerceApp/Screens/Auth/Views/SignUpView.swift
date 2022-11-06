//
//  SignUpView.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import UIKit

final class SignUpView: UIView {
    //MARK: - Properties
    weak var delegate: SignUpViewDelegate?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .whiteLarge
        spinner.color = UIColor(named: "primary")
        return spinner
    }()
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()
    
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
        label.text = "Sign Up"
        label.font = UIFont(name: "Helvetica", size: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Username",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        return textField
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
    
    private let passwordAgainTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password Again",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
        return button
    }()
    
    private let accountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Do you have an account?", for: .normal)
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
        setupDimmedView()
        setupSpinner()
    }
    private func setupSpinner(){
        addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            spinner.widthAnchor.constraint(equalToConstant: 75.0),
            spinner.heightAnchor.constraint(equalToConstant: 75.0)
        ])
    }
    
    private func setupDimmedView() {
        addSubview(dimmedView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: self.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
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
        verticalStackView.addArrangedSubview(usernameTextField)
        verticalStackView.addArrangedSubview(emailTextField)
        verticalStackView.addArrangedSubview(passwordTextField)
        verticalStackView.addArrangedSubview(passwordAgainTextField)
        verticalStackView.addArrangedSubview(signUpButton)
        verticalStackView.addArrangedSubview(accountButton)
        textFieldConfigure(usernameTextField)
        textFieldConfigure(emailTextField)
        textFieldConfigure(passwordTextField)
        textFieldConfigure(passwordAgainTextField)
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
    
    @objc private func didTapSignUp() {
        UIView.animate(withDuration: 1.0) {
            self.dimmedView.alpha = 0.7
            self.spinner.startAnimating()
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: { [weak self] in
            guard let self = self else { return }
            guard let username = self.usernameTextField.text,
                  let email = self.emailTextField.text,
                  let password = self.passwordTextField.text,
                  let passwordAgain = self.passwordAgainTextField.text else {
                return
            }
            self.delegate?.didTapSignUp(username: username,
                                   email: email,
                                   password: password,
                                   passwordAgain: passwordAgain)
            self.spinnerHide()
        })
    }
    
    @objc private func didTapAccount() {
        delegate?.didTapDoAccount()
    }
    
    private func spinnerHide() {
        UIView.animate(withDuration: 1.0) {
            self.spinner.stopAnimating()
            self.spinner.hidesWhenStopped = true
            self.dimmedView.alpha = 0.0
        }
    }
}
