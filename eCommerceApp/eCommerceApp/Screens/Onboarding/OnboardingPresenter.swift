//
//  OnboardingPresenter.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 5.11.2022.
//

import UIKit

final class OnboardingPresenter: ViewToPresenterOnboardingProtocol {
    var view: PresenterToViewOnboardingProtocol?
    
    var interactor: PresenterToInteractorOnboardingProtocol?
    
    var router: PresenterToRouterOnboardingProtocol?
    
    var currentPageNumber: Int = .zero {
        didSet {
            view?.didChangePageNumber(currentPageNumber)
        }
    }
    
    var onboardingView: [CustomOnboardingView]? {
        didSet {
            guard let onboardingView = onboardingView else { return }
            view?.didAddOnboardingView(onboardingView)
        }
    }
    
    var contentOffset: CGPoint? {
        didSet {
            guard let contentOffset = contentOffset else { return }
            view?.didUpdateContentOffset(contentOffset)
        }
    }
    
    func updateScrollViewContentOffset(with pageNumber: Int) {
        contentOffset = CGPoint(x: UIScreen.main.bounds.width * CGFloat(pageNumber), y: .zero)
    }
    
    func didTapNextButton(pageNumber: Int) {
        guard let onboardingView = onboardingView else { return }
        var pageNumber = pageNumber
        if pageNumber < onboardingView.count - 1 {
            pageNumber += 1
            currentPageNumber = pageNumber
        } else {
            didTapSkipButton()
        }
    }
    
    func didTapPrevButton(pageNumber: Int) {
        var pageNumber = pageNumber
        if pageNumber > 0 {
            pageNumber -= 1
            currentPageNumber = pageNumber
        }
    }
    
    func didTapSkipButton() {
        interactor?.setUserDefaults()
    }
    
    func setupScrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        currentPageNumber = currentPage
    }
    
    func addOnboardingView() {
        interactor?.createOnboardingView()
    }
}

extension OnboardingPresenter: InteractorToPresenterOnboardingProtocol {
    func didCreateOnboardingView(_ onboardingView: [CustomOnboardingView]?) {
        self.onboardingView = onboardingView
    }
    
    func didSetUserDefaults() {
        router?.pushToAuth(on: view!)
    }
}
