//
//  SplashView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/22.
//

import UIKit

import Lottie

final class SplashView: UIViewController {
    
    lazy var authManager = AuthManager(apiService: APIManager(), environment: .development)
    
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
        lottiView.play { _ in
            self.isAutoLogin()
        }
    }
}

extension SplashView {
    
    func isAutoLogin() {
        Task {
            do {
                print(UserDefaultsManager.socialID)
                print(UserDefaultsManager.fcmToken)
                
                let result = try await authManager.signIn(socialId: UserDefaultsManager.socialID,
                                                          deviceToken: UserDefaultsManager.fcmToken)
                
                guard let isNewUser = result?.isNew else {
                    self.transitionToSignInViewController()
                    return
                }
                
                if isNewUser {
                    self.transitionToSignInViewController()

                } else {
                    self.transitionToMainViewController()
                }
                
            } catch {
                self.transitionToSignInViewController()
            }
        }
    }
    
    func transitionToSignInViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = SocialSignInViewController.instanceFromNib()
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    func transitionToMainViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = TabBarController()
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
