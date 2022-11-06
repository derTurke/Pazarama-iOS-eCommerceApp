//
//  OnboardingViewController.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 27.10.2022.
//

import UIKit
final class OnboardingViewController: UIViewController {
    //MARK: - Properties
    private let customView = OnboardingView()
    var presenter: ViewToPresenterOnboardingProtocol!
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view = customView
        customView.delegate = self
        customView.scrollViewDelegate(self)
        presenter.addOnboardingView()
    }
}

//MARK: - UIScrollViewDelegate
extension OnboardingViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        presenter.setupScrollViewDidEndDecelerating(scrollView)
    }
}

//MARK: - ViewDelegate
extension OnboardingViewController: OnboardingViewDelegate {
    func updateScrollViewContentOffset(with pageNumber: Int) {
        presenter.updateScrollViewContentOffset(with: pageNumber)
    }
    
    func didTapNextButton(pageNumber: Int) {
        presenter.didTapNextButton(pageNumber: pageNumber)
    }
    
    func didTapPrevButton(pageNumber: Int) {
        presenter.didTapPrevButton(pageNumber: pageNumber)
    }
    
    func didTapSkipButton() {
        presenter.didTapSkipButton()
    }
}

//MARK: - PresenterToViewOnboardingProtocol
extension OnboardingViewController: PresenterToViewOnboardingProtocol {
    func didAddOnboardingView(_ onboardingView: [CustomOnboardingView]) {
        customView.customView = onboardingView
    }
    
    func didChangePageNumber(_ currentPageNumber: Int) {
        customView.currentPageNumber = currentPageNumber
    }
    
    func didUpdateContentOffset(_ offset: CGPoint) {
        customView.setupContentOffset(offset)
    }
    
    
}
