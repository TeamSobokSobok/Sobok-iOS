//
//  SignUpViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/11.
//

import UIKit

final class SignUpViewController: BaseViewController {

    // MARK: Properties
    private var user = SignUpUserData.shared
    private var isEmailRight: Bool = false
    private var isPasswordRight: Bool = false
    private var isRePasswordRight: Bool = false
    
    // MARK: @IBOutlet Properties
    @IBOutlet weak var titleTextLabel: UILabel!
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
        navigationController?.navigationBar.isHidden = true
    
        titleTextLabel.setTypoStyle(font: UIFont(name: "Pretendard-Medium", size: 23)!, kernValue: 0, lineSpacing: 8)
    
        // corner radius (텍스트필드, 버튼)
        [emailTextFieldView, passwordTextFieldView, rePasswordTextFieldView].forEach {$0.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)}
         confirmButton.makeRounded(radius: 12)
        
        // 경고문구 사라지게 만들기
        [emailWarningStackView, passwordWarningStackView, rePasswordWarningStackView].forEach({$0.isHidden = true})
        
        // 버튼비활성화
        confirmButton.isEnabled = false
    }
    
    // MARK: Functions
    private func checkTextField() {
        // 입력 중 일때
        emailTextField.addTarget(self, action: #selector(self.checkEmailTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(self.checkPasswordTextField), for: .editingChanged)
        rePasswordTextField.addTarget(self, action: #selector(self.checkRepasswordTextField), for: .editingChanged)
                
        // 입력 완료했을 때
        emailTextField.addTarget(self, action: #selector(self.inactivateEmailTextField), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(self.inactivatePasswordTextField), for: .editingDidEnd)
        rePasswordTextField.addTarget(self, action: #selector(self.inactivateRepasswordTextField), for: .editingDidEnd)
        
        // 버튼 활성화 조건
        [passwordTextField, rePasswordTextField].forEach {$0.addTarget(self, action: #selector(self.activateOkayButton), for: .editingChanged)}
        emailTextField.addTarget(self, action: #selector(self.activateOkayButton), for: .editingDidEnd)
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
        return passwordTextField.text == rePasswordTextField.text
    }
    
    // 이메일 텍필 값 바뀔 때
    @objc private func checkEmailTextField() {
        emailTextFieldView.layer.borderColor = Color.gray600.cgColor
        emailWarningStackView.isHidden = true
    }
    @objc private func inactivateEmailTextField() {
        isEmailRight = checkEmailRight(input: emailTextField.text ?? "")
        emailWarningStackView.isHidden = isEmailRight || !emailTextField.hasText ? true : false
        emailTextFieldView.layer.borderColor = isEmailRight || !emailTextField.hasText ? Color.gray300.cgColor : Color.pillColorRed.cgColor
    }
    
    // 비밀번호 텍필 값 바뀔 때
    @objc private func checkPasswordTextField() {
        // 비밀번호 텍필
        isPasswordRight = checkPasswordRight(input: passwordTextField.text ?? "")
        passwordWarningStackView.isHidden = isPasswordRight || !passwordTextField.hasText ? true : false
        passwordTextFieldView.layer.borderColor = isPasswordRight || !passwordTextField.hasText ? Color.gray600.cgColor : Color.pillColorRed.cgColor
        
        // 비밀번호 확인 텍필
        isRePasswordRight = checkRepasswordRight(input: passwordTextField.text ?? "")
        rePasswordWarningStackView.isHidden = isRePasswordRight || !rePasswordTextField.hasText ? true : false
        rePasswordTextFieldView.layer.borderColor = isRePasswordRight || !rePasswordTextField.hasText ? Color.gray300.cgColor : Color.pillColorRed.cgColor
    }
    @objc private func inactivatePasswordTextField() {
        passwordTextFieldView.layer.borderColor = isPasswordRight ? Color.gray300.cgColor : Color.pillColorRed.cgColor
    }
    
    // 비밀번호 확인 텍필 값 바뀔 떄
    @objc private func checkRepasswordTextField() {
        isRePasswordRight = checkRepasswordRight(input: passwordTextField.text ?? "")
        rePasswordWarningStackView.isHidden = isRePasswordRight || !rePasswordTextField.hasText ? true : false
        rePasswordTextFieldView.layer.borderColor = isRePasswordRight || !rePasswordTextField.hasText ? Color.gray600.cgColor : Color.pillColorRed.cgColor
    }
    @objc private func inactivateRepasswordTextField() {
        rePasswordTextFieldView.layer.borderColor = isRePasswordRight ? Color.gray300.cgColor : Color.pillColorRed.cgColor
    }
    
    // 버튼 활성화
    @objc func activateOkayButton() {
        confirmButton.isEnabled = isEmailRight && isPasswordRight && isRePasswordRight
    }
    
    // MARK: - @IBAction Properties
    @IBAction func touchUpToPopToSIgnInVIew(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    // 회원가입 버튼 클릭
    @IBAction func touchUpToSignUp(_ sender: UIButton) {
        user.email = emailTextField.text ?? ""
        user.password = passwordTextField.text ?? ""
        navigationController?.pushViewController(SetNickNameVIewController.instanceFromNib(), animated: true)
    }
}
