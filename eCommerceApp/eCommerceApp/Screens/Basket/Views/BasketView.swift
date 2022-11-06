//
//  BasketView.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 2.11.2022.
//

import UIKit

final class BasketView: UIView {
    //MARK: - Properties
    weak var delegate: BasketViewDelegate?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "background")
        tableView.tintColor = UIColor(named: "background")
        tableView.showsVerticalScrollIndicator = false
        tableView.register(BasketTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primary")
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 8
        return view
    }()
    
    private let horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "Total Price:"
        return label
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-bold", size: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "$0.00"
        return label
    }()
    
    private let buyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Buy", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = false
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 12
        button.addTarget(self, action: #selector(didTapBuyButton(_:)), for: .touchUpInside)
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
        setupBottomView()
        setupHorizontalStackView()
        setupBuyButton()
        setupTableView()
    }
    
    private func setupBottomView() {
        addSubview(bottomView)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -125.0)
        ])
    }
    
    private func setupHorizontalStackView() {
        bottomView.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(priceLabel)
        horizontalStackView.addArrangedSubview(totalPriceLabel)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 5.0),
            horizontalStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16.0),
            horizontalStackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16.0)
        ])
    }
    
    private func setupBuyButton() {
        bottomView.addSubview(buyButton)
        buyButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buyButton.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 16.0),
            buyButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 16.0),
            buyButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -16.0),
            buyButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -30.0)
        ])
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
        ])
    }
    
    @objc private func didTapBuyButton(_ sender: UIButton) {
        delegate?.didTapBuyButton()
    }
    
    func setTableViewDelegate(_ delegate: UITableViewDelegate, andDataSource datasource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = datasource
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    func reloadTotalPrice(_ totalPrice: Double) {
        totalPriceLabel.text = "\(totalPrice.priceFormatted)"
    }
    
}
