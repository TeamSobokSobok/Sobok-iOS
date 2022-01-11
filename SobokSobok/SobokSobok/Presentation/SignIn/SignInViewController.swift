//
//  SignInViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/11.
//

import UIKit

final class SignInViewController: BaseViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toucuUpToSetAutoLogIn(_ sender: Any) {
        print("자동로그인")
    }
    @IBAction func touchUpToLogin(_ sender: Any) {
        print("이메일:\(emailTextField.text),  비번:\(passwordTextField.text)")
    }
    @IBAction func touchUpToMoveToSignUpView(_ sender: Any) {
        print("회원가입")
        navigationController?.pushViewController(SignUpViewController.instanceFromNib(), animated: true)
    }
    
}
