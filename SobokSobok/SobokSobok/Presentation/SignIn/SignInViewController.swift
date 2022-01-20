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
        addTarget()
    }
    
    override func style() {
        navigationController?.navigationBar.isHidden = true
        inactivateTextField()
        titleTextLabel.setTypoStyle(font: UIFont(name: "Pretendard-Bold", size: 23)!, kernValue: 0, lineSpacing: 8)
        logInButton.isEnabled = false
        logInButton.makeRounded(radius: 12)
    }
    
    // MARK: - Functions
    private func addTarget() {
        emailTextField.addTarget(self, action: #selector(self.activateEmailTextField), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(self.activatePasswordTextField), for: .editingDidBegin)
        [emailTextField, passwordTextField].forEach({$0.addTarget(self, action: #selector(self.inactivateTextField), for: .editingDidEnd)})
        [emailTextField, passwordTextField].forEach({$0.addTarget(self, action: #selector(self.activateLogInButton), for: .editingChanged)})
    }
    
    // 텍스트 필드 활성화
    @objc private func activateEmailTextField() {
        emailTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray600.cgColor)
    }
    @objc private func activatePasswordTextField() {
        passwordTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray600.cgColor)
    }
    
    // 텍스트 필드 비활성화
    @objc private func inactivateTextField() {
        emailTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        passwordTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
    }
    
    // 버튼 활성화
    @objc private func activateLogInButton() {
        logInButton.isEnabled = emailTextField.hasText && passwordTextField.hasText
    }
    
    // 토스트 메세지
    private func showToast(message: String) {
        var toastLabel = UILabel()
        toastLabel = UILabel(frame: CGRect(x: 20,
                                           y: self.view.frame.size.height - 95,
                                           width: self.view.frame.size.width - 40,
                                           height: 47))
        toastLabel.backgroundColor = Color.black
        toastLabel.textColor = Color.white
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.5, delay: 0.1,
                       options: .curveEaseIn, animations: { toastLabel.alpha = 0.0 },
                       completion: {_ in toastLabel.removeFromSuperview() })
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
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        SignAPI.shared.signIn(email: email, password: password, completion: {(result) in
            switch result {
            case .success:
                self.showToast(message: "로그인 성공 : \(email), \(password)")
            case .requestErr:
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
