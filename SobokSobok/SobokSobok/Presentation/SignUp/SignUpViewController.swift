//
//  SignUpViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/11.
//

import UIKit

final class SignUpViewController: BaseViewController {

    // MARK: Properties
    var emailRight: Bool = false
    var passwordRight: Bool = false
    var rePasswordRight: Bool = false
    
    // MARK: @IBOutlet Properties
    @IBOutlet weak var okayButton: UIButton!
    // 텍스트필드
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailTextFieldView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextFieldView: UIView!
    @IBOutlet weak var rePasswordTextField: UITextField!
    @IBOutlet weak var rePasswordTextFieldView: UIView!
    // 경고문
    @IBOutlet weak var emailWarningStackView: UIStackView!
    @IBOutlet weak var passwordWarningStackView: UIStackView!
    @IBOutlet weak var rePasswordWarningStackView: UIStackView!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        checkTextField()
    }
    
    // MARK: Functions
    private func setUI() {
        emailTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        passwordTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        rePasswordTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
    }
    
    private func securePassword() {
        passwordTextField.isSecureTextEntry = true
        rePasswordTextField.isSecureTextEntry = true
    }
    
    private func checkTextField() {
        emailWarningStackView.isHidden = true
        emailTextField.addTarget(self, action: #selector(self.checkEmailTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.checkPasswordTextField), for: .editingChanged)
        rePasswordTextField.addTarget(self, action: #selector(self.checkRepasswordTextField), for: .editingChanged)
    }
    
    @objc private func checkEmailTextField() {
        if emailRight || !emailTextField.hasText {
            emailWarningStackView.isHidden = true
        } else {
            emailWarningStackView.isHidden = false
        }
    }
    
    @objc private func checkPasswordTextField() {
        
    }
    
    @objc private func checkRepasswordTextField() {
        
    }

    // Alert
    func tempAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc func activateOkayButton(_ : UIButton) {
        okayButton.isEnabled = emailRight && passwordRight && rePasswordRight ? true : false
    }
    
    @IBAction func touchUpToSignUp(_ sender: UIButton) {
        if passwordTextField.text == rePasswordTextField.text {
            tempAlert(title: "회원가입", message: "이메일 : \(emailTextField.text ?? ""), 비밀번호 : \(passwordTextField.text ?? "")")
        } else {
            tempAlert(title: "오류", message: "비밀번호를 확인해주세요")
        }
    }
}
