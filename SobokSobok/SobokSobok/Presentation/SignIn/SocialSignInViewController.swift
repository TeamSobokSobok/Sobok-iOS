//
//  SocialSignInViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/03/07.
//

import UIKit

class SocialSignInViewController: BaseViewController {

    @IBOutlet weak var kakaoLoginButton: UIView!
    @IBOutlet weak var appleLoginButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func layout() {
        kakaoLoginButton.makeRounded(radius: 6)
        appleLoginButton.makeRounded(radius: 6)
    }
}
