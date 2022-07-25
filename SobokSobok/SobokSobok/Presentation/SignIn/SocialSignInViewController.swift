//
//  SocialSignInViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/03/07.
//

import UIKit

protocol SocialSignInProtocol: StyleProtocol {}

final class SocialSignInViewController: UIViewController, SocialSignInProtocol {

    @IBOutlet weak var kakaoLoginButton: UIView!
    @IBOutlet weak var appleLoginButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    func style() {
        kakaoLoginButton.makeRounded(radius: 6)
        appleLoginButton.makeRounded(radius: 6)
    }
    
    @IBAction func signInWithKakao(_ sender: UIView) {
        print("kakao")
    }
    @IBAction func signInWIthApple(_ sender: UIView) {
        print("apple")
    }
    
}
