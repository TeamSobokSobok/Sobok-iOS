//
//  SignUpViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/11.
//

import UIKit

final class SignUpViewController: BaseViewController {

    // MARK: Properties
    private var isEmailRight: Bool = false
    private var isPasswordRight: Bool = false
    private var isRePasswordRight: Bool = false
    
    // MARK: @IBOutlet Properties
    @IBOutlet weak var confirmButton: UIButton!
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
        checkTextField()
    }
    
    override func style() {
        
        // corner radius (텍스트필드, 버튼)
        [emailTextFieldView, passwordTextFieldView, rePasswordTextFieldView].forEach {$0.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)}
         confirmButton.makeRounded(radius: 12)
        
        // 경고문구 사라지게 만들기
        [emailWarningStackView, passwordWarningStackView, rePasswordWarningStackView].forEach({$0.isHidden = true})
        
        // 버튼비활성화
        confirmButton.isEnabled = false
        
        // 네비게이션 바 커스텀
        title = "회원가입"
        let backButton = UIBarButtonItem()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        backButton.title = ""
        backButton.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    // MARK: Functions
    
    // 비밀번호 숨기기
    private func securePassword() {
        passwordTextField.isSecureTextEntry = true
        rePasswordTextField.isSecureTextEntry = true
    }
    
    // 텍스트필드 addTarget
    private func checkTextField() {
        emailTextField.addTarget(self, action: #selector(self.checkEmailTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.checkPasswordTextField), for: .editingChanged)
        [passwordTextField, rePasswordTextField].forEach {$0.addTarget(self, action: #selector(self.checkRepasswordTextField), for: .editingChanged)}
        [emailTextField, passwordTextField, rePasswordTextField].forEach {$0.addTarget(self, action: #selector(self.activateOkayButton(_:)), for: .editingChanged)}
    }
    
    // 정규식 체크
    private func checkEmailRight (input: String) -> Bool {
        // 이메일 조건 : [대문자,소문자,숫자,특수기호] + 골뱅이(@) + [대문자,소문자,숫자,.,-] + 점(.) + [대문자,소문자] 2~64글자
        let validEmail = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", validEmail)
          return emailTest.evaluate(with: input)
    }
    
    private func checkPasswordRight (input: String) -> Bool {
        // 비밀번호 조건 : [대문자,소문자,숫자,특수기호] 8~16글자
        let validPassword = "[A-Z0-9a-z!@#$%^&*()_+=-]{8,16}"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", validPassword)
          return passwordTest.evaluate(with: input)
    }
    
    private func checkRepasswordRight (input: String) -> Bool {
        // 비밀번호 재입력 조건 : 비밀번호와 값이 같아야함
        return passwordTextField.text == rePasswordTextField.text ? true : false
    }

    // Alert
    func tempAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // 조건에 따른 경고문구 숨김여부 결정
    @objc private func checkEmailTextField() {
        isEmailRight = checkEmailRight(input: emailTextField.text ?? "")
        emailWarningStackView.isHidden = isEmailRight || !emailTextField.hasText ? true : false
        emailTextFieldView.layer.borderColor = isEmailRight || !emailTextField.hasText ? Color.gray300.cgColor : Color.pillColorRed.cgColor
    }
    
    @objc private func checkPasswordTextField() {
        isPasswordRight = checkPasswordRight(input: passwordTextField.text ?? "")
        passwordWarningStackView.isHidden = isPasswordRight || !passwordTextField.hasText ? true : false
        passwordTextFieldView.layer.borderColor = isPasswordRight || !passwordTextField.hasText ? Color.gray300.cgColor : Color.pillColorRed.cgColor
    }
    
    @objc private func checkRepasswordTextField() {
        isRePasswordRight = checkRepasswordRight(input: passwordTextField.text ?? "")
        rePasswordWarningStackView.isHidden = isRePasswordRight || !rePasswordTextField.hasText ? true : false
        rePasswordTextFieldView.layer.borderColor = isRePasswordRight || !rePasswordTextField.hasText ? Color.gray300.cgColor : Color.pillColorRed.cgColor
    }
    
    // 버튼 활성화
    @objc func activateOkayButton(_ : UIButton) {
        confirmButton.isEnabled = isEmailRight && isPasswordRight && isRePasswordRight
    }
    
    // 회원가입 버튼 클릭
    @IBAction func touchUpToSignUp(_ sender: UIButton) {
        if passwordTextField.text == rePasswordTextField.text {
            tempAlert(title: "회원가입", message: "이메일 : \(emailTextField.text ?? ""), 비밀번호 : \(passwordTextField.text ?? "")")
        } else {
            tempAlert(title: "오류", message: "비밀번호를 확인해주세요")
        }
    }
}
