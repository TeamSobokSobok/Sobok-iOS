//
//  SocialSignInViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/03/07.
//

import UIKit
import AuthenticationServices

protocol SocialSignInProtocol: StyleProtocol {}

final class SocialSignInViewController: UIViewController, SocialSignInProtocol {

    @IBOutlet weak var kakaoLoginButton: UIView!
    @IBOutlet weak var appleLoginButton: UIView!
    
    lazy var appleLoginManager = AppleLoginManager()
    
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
        print("kakao")
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

    }
    
    func appleLoginDidFail() {
        
    }
}
