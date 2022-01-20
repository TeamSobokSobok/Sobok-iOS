//
//  SignInViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/11.
//

import UIKit

final class SignInViewController: BaseViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailTextFieldView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextFieldView: UIView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkTextField()
        securePassword()
    }
    
    override func style() {
        titleTextLabel.setTypoStyle(font: UIFont(name: "Pretendard-Bold", size: 23)!, kernValue: 0, lineSpacing: 8)
        logInButton.makeRounded(radius: 12)
        emailTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        passwordTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
    }
    
    // MARK: - Functions
    private func securePassword() {
        passwordTextField.isSecureTextEntry = true
    }

    private func checkTextField() {
        logInButton.isEnabled = false
        signUpButton.isEnabled = true
        emailTextField.addTarget(self, action: #selector(activateEmailTextField(_:)), for: .editingDidBegin)
        emailTextField.addTarget(self, action: #selector(inactivateEmailTextField(_:)), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(activatePasswordTextField(_:)), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(inactivatePasswordTextField(_:)), for: .editingDidEnd)
        self.emailTextField.addTarget(self, action: #selector(self.activateLogInButton(_:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.activateLogInButton(_:)), for: .editingChanged)
    }
    
    // Alert
    func tempAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
        
    // 토스트 메세지
    private func showToast(message: String) {
        var toastLabel = UILabel()
        // 토스트 위치
        toastLabel = UILabel(frame: CGRect(x: 20,
                                           y: self.view.frame.size.height - 95,
                                           width: self.view.frame.size.width - 40,
                                           height: 47))
        // 토스트 색
        toastLabel.backgroundColor = Color.black
        toastLabel.textColor = Color.white
        // 토스트 값
        toastLabel.text = message
        // 토스트 모양
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        // 토스트 애니메이션
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.5, delay: 0.1,
                       options: .curveEaseIn, animations: { toastLabel.alpha = 0.0 },
                       completion: {_ in toastLabel.removeFromSuperview() })
    }
        
    @objc private func activateEmailTextField(_ : UIView) {
        emailTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray600.cgColor)
    }
    @objc private func inactivateEmailTextField(_ : UIView) {
        emailTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
    }
    @objc private func activatePasswordTextField(_ : UIView) {
        passwordTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray600.cgColor)
    }
    @objc private func inactivatePasswordTextField(_ : UIView) {
        passwordTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
    }
    
    @objc func activateLogInButton(_ : UIButton) {
        let emailFilled = emailTextField.hasText
        let passwordFilled = passwordTextField.hasText
        
        if emailFilled && passwordFilled {
            logInButton.isEnabled = true
        } else {
            logInButton.isEnabled = false
        }
    }
    
    // MARK: - @IBAction Properties
    
    @IBAction func touchUpToLogin(_ sender: UIButton) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        signIn()
    }
    
    @IBAction func touchUpToMoveToSignUpView(_ sender: UIButton) {
        navigationController?.pushViewController(SignUpViewController.instanceFromNib(), animated: true)
    }
}

extension SignInViewController {
    func signIn() {
        guard let email = emailTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        
        SignInAPI.shared.signIn(email: email, password: password, completion: {(result) in
            switch result {
            case .success(_):
                self.showToast(message: "로그인 성공 : \(email), \(password)")
            case .requestErr(_):
                self.showToast(message: "이메일 또는 비밀번호를 다시 확인해주세요")
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        })
    }
}
