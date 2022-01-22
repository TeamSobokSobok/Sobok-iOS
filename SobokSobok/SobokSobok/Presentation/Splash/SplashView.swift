//
//  SplashView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/22.
//

import UIKit

import Lottie

final class SplashView: BaseViewController {
    
    // MARK: - Properties
    lazy var lottiView: AnimationView = {
        let animationView = AnimationView(name: "splash")
        animationView.frame = CGRect(x: 87, y: 260, width: 200, height: 260)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFit
        animationView.stop()
        animationView.isHidden = true
        
        return animationView
    }()

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addLottieView()
    }
    
    // MARK: - Functions
    private func addLottieView() {
        view.addSubview(lottiView)
        lottiView.isHidden = false
        lottiView.play { (finished) in
            let nextVC = SignInViewController.instanceFromNib()
            nextVC.modalTransitionStyle = .crossDissolve
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }
}
