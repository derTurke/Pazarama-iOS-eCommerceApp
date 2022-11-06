//
//  OnboardingContract.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 5.11.2022.
//

import UIKit

// MARK: View Output (Presenter -> View)
protocol PresenterToViewOnboardingProtocol: AnyObject {
    func didChangePageNumber(_ currentPageNumber: Int)
    func didUpdateContentOffset(_ offset: CGPoint)
    func didAddOnboardingView(_ onboardingView: [CustomOnboardingView])
}

// MARK: View Input (View -> Presenter)
protocol ViewToPresenterOnboardingProtocol {
    var view: PresenterToViewOnboardingProtocol? { get set }
    var interactor: PresenterToInteractorOnboardingProtocol? { get set }
    var router: PresenterToRouterOnboardingProtocol? { get set }
    
    var currentPageNumber: Int { get set}
    var onboardingView: [CustomOnboardingView]? { get set }
    var contentOffset: CGPoint? { get set }
    
    func updateScrollViewContentOffset(with pageNumber: Int)
    func didTapNextButton(pageNumber: Int)
    func didTapPrevButton(pageNumber: Int)
    func didTapSkipButton()
    func setupScrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    func addOnboardingView()
}

// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorOnboardingProtocol {
    var presenter: InteractorToPresenterOnboardingProtocol? { get set }
    
    func createOnboardingView()
    func setUserDefaults()
}

// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterOnboardingProtocol: AnyObject {
    func didCreateOnboardingView(_ onboardingView: [CustomOnboardingView]?)
    func didSetUserDefaults()
}

// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterOnboardingProtocol {
    static func createModule() -> UIViewController
    func pushToAuth(on view: PresenterToViewOnboardingProtocol)
}

protocol OnboardingViewDelegate: AnyObject {
    func updateScrollViewContentOffset(with pageNumber: Int)
    func didTapNextButton(pageNumber: Int)
    func didTapPrevButton(pageNumber: Int)
    func didTapSkipButton()
}
