//
//  OnboardingInteractor.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 5.11.2022.
//

import UIKit

final class OnboardingInteractor: PresenterToInteractorOnboardingProtocol {
    var presenter: InteractorToPresenterOnboardingProtocol?
    
    private let defaults = UserDefaults.standard
    
    func createOnboardingView() {
        let firstOnboardingView = CustomOnboardingView()
        firstOnboardingView.image = UIImage(named: "onboard-1")
        firstOnboardingView.text = "Güvenilir ve kullanıcı dostu olan pazaryeri uygulamasına hoşgeldiniz."
        
        let secondOnboardingView = CustomOnboardingView()
        secondOnboardingView.image = UIImage(named: "onboard-2")
        secondOnboardingView.text = "Siparişlerinizi hızlıca verebilmeniz için ışık hızında bir pazaryeri olma yolunda ilerlemeye ve gelişmeye devam ediyoruz."
        
        let customViews = [firstOnboardingView, secondOnboardingView]
        
        presenter?.didCreateOnboardingView(customViews)
    }
    
    func setUserDefaults() {
        defaults.set(1, forKey: "skipOnboarding")
        presenter?.didSetUserDefaults()
    }
    
}
