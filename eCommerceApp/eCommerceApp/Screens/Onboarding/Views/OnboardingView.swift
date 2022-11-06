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
    
    var currentPageNumber: Int = .zero {
        didSet {
            guard let customView = customView else { return }
            if currentPageNumber == customView.count - 1 {
                nextButton.setTitle("Done", for: .normal)
            } else {
                nextButton.setTitle("Next", for: .normal)
            }
                
            if currentPageNumber == .zero {
                prevButton.isHidden = true
            } else {
                prevButton.isHidden = false
            }
                
            pageControl.currentPage = currentPageNumber
            updateScrollViewContentOffset(with: currentPageNumber)
        }
    }
    
    var customView: [CustomOnboardingView]? {
        didSet {
            guard let customView = customView else { return }
            let numberOfPages = customView.count
            scrollView.contentSize.width = UIScreen.main.bounds.width * CGFloat(numberOfPages)
            pageControl.numberOfPages = numberOfPages
            for x in 0..<customView.count {
                scrollView.addSubview(customView[x])
                customView[x].translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    customView[x].leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: UIScreen.main.bounds.width * CGFloat(x)),
                    customView[x].topAnchor.constraint(equalTo: holderView.topAnchor),
                    customView[x].bottomAnchor.constraint(equalTo: holderView.bottomAnchor),
                    customView[x].widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
                    
                ])
            }
        }
    }
    
    private let holderView = UIView()
    private let scrollView = UIScrollView()
    
    private let pageControl: UIPageControl = {
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
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "primary")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapNextButton(_:)), for: .touchUpInside)
        return button
    }()
        
    private let prevButton: UIButton = {
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
        super.init(frame: frame)
        backgroundColor = .white
        setupSkipButton()
        setupPageControl()
        setupNextButton()
        setupPrevButton()
        setupHolderView()
        setupScrollView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    private func setupSkipButton() {
        addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            skipButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            skipButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10.0)
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
    
    private func setupHolderView() {
        addSubview(holderView)
        holderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            holderView.topAnchor.constraint(equalTo: skipButton.bottomAnchor, constant: 5.0),
            holderView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            holderView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            holderView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -10.0),
        ])
    }
    
    private func setupScrollView() {
        holderView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isPagingEnabled = true
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: holderView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: holderView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: holderView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: holderView.bottomAnchor),
            scrollView.centerYAnchor.constraint(equalTo: holderView.centerYAnchor),
            scrollView.centerXAnchor.constraint(equalTo: holderView.centerXAnchor),
        ])
    }
    
    @objc private func didTapSkipButton() {
        delegate?.didTapSkipButton()
    }
    
    @objc private func didTapNextButton(_ sender: UIButton) {
        delegate?.didTapNextButton(pageNumber: currentPageNumber)
    }
    
    @objc private func didTapPrevButton() {
        delegate?.didTapPrevButton(pageNumber: currentPageNumber)
    }
    
    private func updateScrollViewContentOffset(with pageNumber: Int) {
        UIView.animate(withDuration: 0.3, animations: {
            self.delegate?.updateScrollViewContentOffset(with: pageNumber)
        })
    }
    
    func scrollViewDelegate(_ delegate: UIScrollViewDelegate) {
        scrollView.delegate = delegate
    }
    
    func setupContentOffset(_ offset: CGPoint) {
        scrollView.contentOffset = offset
    }
}
