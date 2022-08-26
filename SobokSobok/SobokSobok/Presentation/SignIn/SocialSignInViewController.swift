//
//  SocialSignInViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/03/07.
//

import UIKit
import AuthenticationServices
import KakaoSDKCommon
import KakaoSDKUser

protocol SocialSignInProtocol: StyleProtocol {}

final class SocialSignInViewController: UIViewController, SocialSignInProtocol {

    @IBOutlet weak var kakaoLoginButton: UIView!
    @IBOutlet weak var appleLoginButton: UIView!
    
    lazy var appleLoginManager = AppleLoginManager()
    lazy var authManager = AuthManager(apiService: APIManager(), environment: .development)
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        style()
        configureAppleLoginManager()
    }
    
    func style() {
        kakaoLoginButton.makeRounded(radius: 6)
        appleLoginButton.makeRounded(radius: 6)
    }
    
    @IBAction func signInWithKakao(_ sender: UIView) {
        kakaoButtonTapped()
    }
    
    @IBAction func signInWIthApple(_ sender: UIView) {
        handleAppleAuthentication()
    }
}

extension SocialSignInViewController {
    
    private func configureAppleLoginManager() {
        appleLoginManager.delegate = self
    }
    
    private func handleAppleAuthentication() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.presentationContextProvider = appleLoginManager
        controller.delegate = appleLoginManager
        controller.performRequests()
    }
}

extension SocialSignInViewController: AppleLoginManagerDelegate {
    func appleLoginDidComplete(userID: String) {
        let appleSocialId = "Apple@" + userID
        signIn(socialID: appleSocialId)
    }
    
    func appleLoginDidFail() {
        
    }
}

extension SocialSignInViewController {
    
    func signIn(socialID: String?) {
        guard let socialID = socialID else {
            print("유효하지 않은 사용자입니다.")
            return
        }
        
        Task {
            let result = try await authManager.signIn(socialId: socialID, deviceToken: UserDefaultsManager.fcmToken)
            guard let isNewUser = result?.isNew else { return }
            guard let accessToken = result?.accesstoken else { return }

            if isNewUser {
                transitionToSetNickNameViewController(socialId: socialID)
                
            } else {
                UserDefaultsManager.socialID = socialID
                UserDefaultsManager.accessToken = accessToken
                transitionToMainViewController()
            }
        }
    }
    
    func transitionToSetNickNameViewController(socialId: String) {
        let setNickNameViewController = SetNickNameVIewController()
        setNickNameViewController.socialId = socialId
        navigationController?.pushViewController(setNickNameViewController, animated: true)
    }
    
    func transitionToMainViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = TabBarController()
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}

extension SocialSignInViewController {
    
    private func kakaoButtonTapped() {

        if UserApi.isKakaoTalkLoginAvailable() {
            self.signInWithApp()
            
        } else {
            self.signUpWithWeb()
        }
    }
    
    private func signInWithApp() {
        UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
            if let error = error {
                print("⛔️⛔️⛔️⛔️", error)
            }
            else {
                self.fetchUserInfomation { socialID in
                    self.signIn(socialID: socialID)
                }
            }
        }
    }

    private func signUpWithWeb() {
        
        UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in

            if let error = error {
                print("⛔️⛔️⛔️⛔️", error)
            }
            else {
                self.fetchUserInfomation { socialID in
                    self.signIn(socialID: socialID)
                }
            }
        }
    }
    
    private func fetchUserInfomation(completion: @escaping ((String) -> ())) {
        UserApi.shared.me { user, error in
            guard let userID = user?.id else { return }
            let socialID = "Kakao@\(userID)"
            completion(socialID)
        }
    }
}
