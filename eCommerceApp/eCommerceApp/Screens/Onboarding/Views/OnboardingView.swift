//
//  OnboardingView.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import UIKit

final class OnboardingView: UIView {
    //MARK: - Properties
    weak var delegate: OnboardingViewDelegate?
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor(named: "primary")
        pageControl.layer.cornerRadius = 12
        return pageControl
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
        return button
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    let prevButton: UIButton = {
        let button = UIButton()
        button.setTitle("Prev", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapPrevButton), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = UIColor(named: "background")
        setupSkipButton()
        setupPageControl()
        setupScrollView()
        setupContentView()
        setupNextButton()
        setupPrevButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 5.0),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -10.0)
        ])
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setupPageControl() {
        addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10.0),
            pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupSkipButton() {
        addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            skipButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0)
        ])
    }
    
    private func setupNextButton() {
        addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5.0),
            nextButton.leadingAnchor.constraint(equalTo: pageControl.trailingAnchor, constant: 10.0),
            nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0)
        ])
    }
    private func setupPrevButton() {
        addSubview(prevButton)
        prevButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            prevButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5.0),
            prevButton.trailingAnchor.constraint(equalTo: pageControl.leadingAnchor, constant: -10.0),
            prevButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0)
        ])
    }
    
    func setScrollViewDelegate(_ delegate: UIScrollViewDelegate) {
        scrollView.delegate = delegate
    }
    
    @objc private func didTapNextButton() {
        delegate?.didTapNextButton()
    }
    
    @objc private func didTapPrevButton() {
        delegate?.didTapPrevButton()
    }
    
    @objc private func didTapSkipButton() {
        delegate?.didTapSkipButton()
    }
}
