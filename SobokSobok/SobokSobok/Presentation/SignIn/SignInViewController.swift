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
    @IBOutlet weak var autoLogIn: UIButton!
    var isSetAutoLogin = true

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
    
    
    @IBAction func touchUpToSetAutoLogIn(_ sender: Any) {
        if(isSetAutoLogin){
            isSetAutoLogin = false
            autoLogIn.setImage(UIImage(systemName: "square"), for: .normal)

        } else {
            isSetAutoLogin = true
            autoLogIn.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
    }
    
    @IBAction func touchUpToLogin(_ sender: Any) {
        tempAlert(title: "로그인", message: "이메일 : \(emailTextField.text), 비밀번호 : \(passwordTextField.text)")
    }
    
    @IBAction func touchUpToMoveToSignUpView(_ sender: Any) {
        navigationController?.pushViewController(SignUpViewController.instanceFromNib(), animated: true)
    }
    
    func tempAlert(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title:"확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated:true)
    }
}
