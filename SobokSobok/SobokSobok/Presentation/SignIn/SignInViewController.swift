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
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkTextField()
    }
    
    private func checkTextField() {
        logInButton.isEnabled = false
        signUpButton.isEnabled = true
        
        self.emailTextField.addTarget(self, action: #selector(self.activateLogInButton(_:)),for:.editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.activateLogInButton(_:)), for: .editingChanged)
    }
    
    @objc func activateLogInButton(_ : UIButton){
        
        let emailFilled = emailTextField.hasText
        let passwordFilled = passwordTextField.hasText
        
        if emailFilled && passwordFilled {
            logInButton.isEnabled = true
        } else {
            logInButton.isEnabled = false
        }
    }
    
    @IBAction func touchUpToLogin(_ sender: Any) {
        print("이메일:\(emailTextField.text),  비번:\(passwordTextField.text)")
    }
    
    @IBAction func touchUpToMoveToSignUpView(_ sender: Any) {
        print("회원가입")
        navigationController?.pushViewController(SignUpViewController.instanceFromNib(), animated: true)
    }
    
}
