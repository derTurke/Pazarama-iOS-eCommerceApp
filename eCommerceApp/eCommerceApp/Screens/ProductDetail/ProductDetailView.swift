//
//  ProductDetailView.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 31.10.2022.
//

import UIKit

final class ProductDetailView: UIView {
    //MARK: - Properties
    weak var delegate: ProductDetailViewDelegate?
    
    var product: Products? {
        didSet {
            guard let product = product,
                  let piece = product.rating?.count,
                  let rating = product.rating?.rate,
                  let price = product.price,
                  let imageURL = product.image,
                  let url = URL(string: imageURL) else {
                return
            }
            productImageView.kf.setImage(with: url)
            titleLabel.text = product.title
            categoryLabel.text = product.category
            pieceLabel.text = "Piece: \(piece)"
            ratingLabel.text = "Rating Point: \(rating)"
            descriptionLabel.text = product.description
            priceLabel.text = "\(price.priceFormatted)"
            stepper.maximumValue = Double(piece)
        }
    }
    
    private let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "left-arrow"), for: .normal)
        button.addTarget(self, action: #selector(didTapDismissButton), for: .touchUpInside)
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView = UIView()
    private let productImageView = UIImageView()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary")
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.25
        view.layer.shadowRadius = 12
        return view
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-bold", size: 18)
        label.numberOfLines = 0
        label.textColor = .black
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = UIColor(named: "primary")
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let pieceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-bold", size: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    private let bottomHorizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let horizontalStepperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        return stackView
    }()
    
    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.minimumValue = 1
        stepper.value = 1
        stepper.addTarget(self, action: #selector(didTapStepper(_:)), for: .touchUpInside)
        return stepper
    }()
    
    private let stepperLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-bold", size: 20)
        label.numberOfLines = 0
        label.textColor = .white
        label.text = "1"
        label.layer.cornerRadius = 8
        return label
    }()
    
    private let addBasketButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add Basket", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 12
        button.addTarget(self, action: #selector(didTapAddBasket), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupView() {
        backgroundColor = UIColor(named: "background")
        setupDismissButton()
        setupBottomView()
        setupScrollView()
        setupContentView()
        setupImageView()
        setupVerticalStackView()
        setupBottomStackView()
    }
    
    private func setupDismissButton() {
        addSubview(dismissButton)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            dismissButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ])
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: dismissButton.bottomAnchor, constant: 5.0),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -125.0),
        ])
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -125.0),
            contentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    private func setupImageView() {
        contentView.addSubview(productImageView)
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        productImageView.image = UIImage(named: "icon")
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productImageView.heightAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
    private func setupVerticalStackView() {
        contentView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(categoryLabel)
        verticalStackView.addArrangedSubview(pieceLabel)
        verticalStackView.addArrangedSubview(ratingLabel)
        verticalStackView.addArrangedSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16.0),
            verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
        ])
    }
    
    private func setupBottomView() {
        addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -120.0),
        ])
    }
    
    private func setupBottomStackView() {
        bottomView.addSubview(bottomStackView)
        bottomStackView.addArrangedSubview(priceLabel)
        bottomStackView.addArrangedSubview(bottomHorizontalStackView)
        bottomHorizontalStackView.addArrangedSubview(horizontalStepperStackView)
        horizontalStepperStackView.addArrangedSubview(stepper)
        horizontalStepperStackView.addArrangedSubview(stepperLabel)
        bottomHorizontalStackView.addArrangedSubview(addBasketButton)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 16.0),
            bottomStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16.0),
            bottomStackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16.0),
            bottomStackView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -30.0)
        ])
    }
    
    @objc private func didTapDismissButton() {
        delegate?.didTapDismiss()
    }
    
    @objc private func didTapStepper(_ sender: UIStepper) {
        delegate?.didTapStepper(product, piece: sender.value)
    }
    
    @objc private func didTapAddBasket() {
        delegate?.didTapAddBasket(product, piece: Int(stepper.value))
    }
    
    func reloadStepper(price: Double, piece: Int) {
        DispatchQueue.main.async {
            self.priceLabel.text = "\(price.priceFormatted)"
            self.stepperLabel.text = "\(piece)"
        }
    }
}


