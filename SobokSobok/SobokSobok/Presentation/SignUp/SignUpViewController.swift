//
//  SignUpViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/11.
//

import UIKit

final class SignUpViewController: BaseViewController {

    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkTextField()
    }

    private func checkTextField(){
        okayButton.isEnabled = false
        
        self.emailTextField.addTarget(self, action: #selector(self.activateOkayButton(_:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.activateOkayButton(_:)), for: .editingChanged)
        self.rePasswordTextField.addTarget(self, action: #selector(self.activateOkayButton(_:)), for: .editingChanged)

    }
    
    @objc func activateOkayButton(_ : UIButton){
        let emailFilled = emailTextField.hasText
        let passwordFilled = passwordTextField.hasText
        let rePasswordFilled = rePasswordTextField.hasText
        
        if emailFilled && passwordFilled && rePasswordFilled {
            okayButton.isEnabled = true
        } else {
            okayButton.isEnabled = false
        }
    }
    
    @IBAction func touchUpToSignUp(_ sender: Any) {
        print("이메일:\(emailTextField.text), 비밀번호:\(passwordTextField.text)")
    }
}
