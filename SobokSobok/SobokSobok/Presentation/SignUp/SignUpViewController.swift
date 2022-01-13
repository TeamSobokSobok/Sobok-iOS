//
//  SignUpViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/11.
//

import UIKit

final class SignUpViewController: BaseViewController {

    // MARK: @IBOutlet Properties
    @IBOutlet weak var okayButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var emailWarning: UILabel!
    @IBOutlet weak var passwordWarning: UILabel!
    @IBOutlet weak var repasswordWarning: UILabel!
    @IBOutlet weak var emailWarning: UIStackView!
    @IBOutlet weak var passwordWarning: UIStackView!
    @IBOutlet weak var rePasswordWarning: UIStackView!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkTextField()
    }
    
    // MARK: Functions
    private func securePassword() {
        passwordTextField.isSecureTextEntry = true
        rePasswordTextField.isSecureTextEntry = true
    }

    private func checkTextField() {
        okayButton.isEnabled = false
        [emailTextField, passwordTextField, rePasswordTextField].forEach {
        $0.addTarget(self, action: #selector(self.activateOkayButton(_:)), for: .editingChanged)}
    }
    
    // Alert
    func tempAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc func activateOkayButton(_ : UIButton) {
        let emailFilled = emailTextField.hasText
        let passwordFilled = passwordTextField.hasText
        let rePasswordFilled = rePasswordTextField.hasText
        
        okayButton.isEnabled = emailFilled && passwordFilled && rePasswordFilled ? true : false
    }
    
    @IBAction func touchUpToSignUp(_ sender: UIButton) {
        if passwordTextField.text == rePasswordTextField.text {
            tempAlert(title: "회원가입", message: "이메일 : \(emailTextField.text ?? ""), 비밀번호 : \(passwordTextField.text ?? "")")
        } else {
            tempAlert(title: "오류", message: "비밀번호를 확인해주세요")
        }
    }
}
