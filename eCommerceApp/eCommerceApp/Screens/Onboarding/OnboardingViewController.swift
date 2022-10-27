//
//  OnboardingViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import UIKit
protocol OnboardingViewDelegate: AnyObject {
    func didTapNextButton()
    func didTapPrevButton()
    func didTapSkipButton()
}

final class OnboardingViewController: UIViewController {
    //MARK: - Properties
    private let onboardingView = OnboardingView()
    private let pageWidth: CGFloat = UIScreen.main.bounds.width
    private var currentPageNumber: Int = .zero {
        didSet {
            if currentPageNumber == onboardingViews.count - 1 {
                onboardingView.nextButton.setTitle("Done", for: .normal)
            } else {
                onboardingView.nextButton.setTitle("Next", for: .normal)
            }
            
            if currentPageNumber == .zero {
                onboardingView.prevButton.isHidden = true
            } else {
                onboardingView.prevButton.isHidden = false
            }
            
            onboardingView.pageControl.currentPage = currentPageNumber
            updateScrollViewContentOffset(with: currentPageNumber)
        }
    }
    private var onboardingViews = [CustomOnboardingView]() {
        didSet {
            let numberOfPages = onboardingViews.count
            onboardingView.scrollView.contentSize.width = CGFloat(numberOfPages) * pageWidth
            onboardingView.pageControl.numberOfPages = numberOfPages
            guard let onboarding = onboardingViews.last else {
                fatalError("OnboardingView not found.")
            }
            onboardingView.contentView.addSubview(onboarding)
            onboarding.translatesAutoresizingMaskIntoConstraints = false
            
            if onboardingViews.count == 1 {
                NSLayoutConstraint.activate([
                    onboarding.leadingAnchor.constraint(equalTo: onboardingView.contentView.leadingAnchor),
                    onboarding.topAnchor.constraint(equalTo: onboardingView.contentView.topAnchor),
                    onboarding.bottomAnchor.constraint(equalTo: onboardingView.contentView.bottomAnchor),
                    onboarding.widthAnchor.constraint(equalToConstant: pageWidth)
                ])
            } else {
                NSLayoutConstraint.activate([
                    onboarding.leadingAnchor.constraint(equalTo: onboardingViews.first!.trailingAnchor),
                    onboarding.topAnchor.constraint(equalTo: onboardingView.contentView.topAnchor),
                    onboarding.bottomAnchor.constraint(equalTo: onboardingView.contentView.bottomAnchor),
                    onboarding.widthAnchor.constraint(equalToConstant: pageWidth),
                    onboarding.trailingAnchor.constraint(equalTo: onboardingView.contentView.trailingAnchor)
                ])
            }
        }
    }
    
    //MARK: - Init
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = onboardingView
        onboardingView.delegate = self
        onboardingView.setScrollViewDelegate(self)
        navigationItem.hidesBackButton = true
        
        let firstOnboardingView = CustomOnboardingView()
        firstOnboardingView.image = UIImage(named: "onboard-1")
        firstOnboardingView.text = "Güvenilir ve kullanıcı dostu olan pazaryeri uygulamasına hoşgeldiniz."
        onboardingViews.append(firstOnboardingView)
        
        let secondOnboardingView = CustomOnboardingView()
        secondOnboardingView.image = UIImage(named: "onboard-2")
        secondOnboardingView.text = "Siparişlerinizi hızlıca verebilmeniz için ışık hızında bir pazaryeri olma yolunda ilerlemeye ve gelişmeye devam ediyoruz."
        onboardingViews.append(secondOnboardingView)
        
    }
    //MARK: - Methods
    private func goAuth() {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    private func updateScrollViewContentOffset(with pageNumber: Int) {
        let contentOffset = CGPoint(x: pageWidth * CGFloat(pageNumber), y: .zero)
        onboardingView.scrollView.setContentOffset(contentOffset, animated: true)
    }
}

extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(onboardingView.scrollView.contentOffset.x / pageWidth)
        currentPageNumber = currentPage
    }
}

extension OnboardingViewController: OnboardingViewDelegate {
    func didTapNextButton() {
        if currentPageNumber < onboardingViews.count - 1 {
            currentPageNumber += 1
        } else {
            goAuth()
        }
    }
    
    func didTapPrevButton() {
        if currentPageNumber > 0 {
            currentPageNumber -= 1
        }
    }
    
    func didTapSkipButton() {
        goAuth()
    }
}
