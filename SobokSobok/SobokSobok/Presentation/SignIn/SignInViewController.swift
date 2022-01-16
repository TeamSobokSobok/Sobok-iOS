//
//  SignInViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/11.
//

import UIKit

final class SignInViewController: BaseViewController {
    
    // MARK: - Properties
    var isSetAutoLogin: Bool = true
    private var isKeyboardOn: Bool = false
    private var keyboardHeight: CGFloat = 0

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailTextFieldView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordTextFieldView: UIView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        checkTextField()
        securePassword()
        checkKeyboardOn()
    }
    
    // MARK: - Functions
    private func setUI() {
        emailTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        passwordTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
    }
    
    private func securePassword() {
        passwordTextField.isSecureTextEntry = true
    }

    private func checkTextField() {
        logInButton.isEnabled = false
        signUpButton.isEnabled = true
        self.emailTextField.addTarget(self, action: #selector(self.activateLogInButton(_:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(self.activateLogInButton(_:)), for: .editingChanged)
    }
    
    private func checkKeyboardOn() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Alert
    func tempAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
        
    // 토스트 메세지
    func showToast(message: String) {
        let isKeyboardOn: Bool = self.isKeyboardOn
        let keyboardHeight: CGFloat = self.keyboardHeight
        var toastLabel = UILabel()
        // 토스트 위치
        if isKeyboardOn {
            toastLabel = UILabel(frame: CGRect(x: 20,
                                               y: self.view.frame.size.height - keyboardHeight - 59,
                                               width: self.view.frame.size.width - 40,
                                               height: 47))
        } else {
            toastLabel = UILabel(frame: CGRect(x: 20,
                                               y: self.view.frame.size.height - 95,
                                               width: self.view.frame.size.width - 40,
                                               height: 47))
        }
        // 토스트 색
        toastLabel.backgroundColor = UIColor(cgColor: Color.black.cgColor)
        toastLabel.textColor = UIColor(cgColor: Color.white.cgColor)
        // 토스트 값
        toastLabel.text = message
        // 토스트 모양
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        // 토스트 애니메이션
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.0, delay: 0.1,
                       options: .curveEaseIn, animations: { toastLabel.alpha = 0.0 },
                       completion: {_ in toastLabel.removeFromSuperview() })
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                keyboardHeight = keyboardFrame.cgRectValue.height
            }
        isKeyboardOn = true
        }
        
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardHeight = 0
        isKeyboardOn = false
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
        // 실패시
        showToast(message: "이메일 또는 비밀번호를 다시 확인해주세요")
        
        // 성공시
        // 메인화면 이동
    }
    
    @IBAction func touchUpToMoveToSignUpView(_ sender: UIButton) {
        navigationController?.pushViewController(SignUpViewController.instanceFromNib(), animated: true)
    }
}
