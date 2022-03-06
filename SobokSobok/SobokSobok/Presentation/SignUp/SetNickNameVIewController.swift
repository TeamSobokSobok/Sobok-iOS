//
//  SetNickNameVIewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/14.
//

import UIKit

import SnapKit

final class SetNickNameVIewController: BaseViewController {

    // MARK: - Properties
    private var user = SignUpUserData.shared
    private let userDefaults = UserDefaults.standard
    var nickname: String?
    
    private var isNickNameRight: Bool = false
    private var isDuplicationChecked: Bool = false
    
    private var isKeyboardOn: Bool = false
    private var keyboardHeight: CGFloat = 0
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var nickNameTextFieldView: UIView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var checkDuplicationButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var warningTextLabel: UILabel!
    @IBOutlet weak var checkDuplicationButtonBottomLine: UIView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargetToTextField()
    }
    
    override func style() {
        navigationController?.navigationBar.isHidden = true
        nickNameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        warningTextLabel.isHidden = true
        signUpButton.makeRounded(radius: 12)
    }
    
    // MARK: Functions
    private func addTargetToTextField() {
        nickNameTextField.addTarget(self, action: #selector(self.activateTextField), for: .editingChanged)
        nickNameTextField.addTarget(self, action: #selector(self.inactivateTextField), for: .editingDidEnd)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: 텍스트필드 관련
    @objc private func activateTextField() {
        initializeDuplicationCheck()
        limitNicknameText()
        checkIsNicknameRight()
        showWarning()
        enableButton()
    }
    private func initializeDuplicationCheck() {
        isDuplicationChecked = false
    }
    private func limitNicknameText() {
        if nickNameTextField.text?.count ?? 0 > 10 {
            nickNameTextField.deleteBackward()
        }
    }
    private func checkIsNicknameRight() {
        isNickNameRight = checkNicknameRegularExpression(input: nickNameTextField.text ?? "")
    }
    private func checkNicknameRegularExpression (input: String) -> Bool {
        // 닉네임 조건 : [영문, 한글, 공백, 숫자] 2~10글자
        let validNickName = "[가-힣0-9a-zA-Z ]{2,10}"
        let nickNameTest = NSPredicate(format: "SELF MATCHES %@", validNickName)
          return nickNameTest.evaluate(with: input)
    }
    private func showWarning() {
        warningTextLabel.isHidden = isNickNameRight || !nickNameTextField.hasText
        nickNameTextFieldView.layer.borderColor = isNickNameRight || !nickNameTextField.hasText ? Color.gray600.cgColor : Color.pillColorRed.cgColor
    }
    private func enableButton() {
        [signUpButton, checkDuplicationButton].forEach({$0?.isEnabled = isNickNameRight})
        checkDuplicationButtonBottomLine.backgroundColor = isNickNameRight ? UIColor(cgColor: Color.darkMint.cgColor) : UIColor(cgColor: Color.gray400.cgColor)
    }

    @objc private func inactivateTextField() {
        nickNameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
    }

    // MARK: 토스트메세지 관련
    private func showToast(message: String) {
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
    // 키보드 Notification
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
    
    // MARK: - @IBAction Properties
    @IBAction func touchUpToDismiss(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpToCheckDuplication(_ sender: UIButton) {
        nickname = nickNameTextField.text ?? ""
        checkUsername()
    }
    
    @IBAction func touchUpToSignUp(_ sender: UIButton) {
        if isDuplicationChecked {
            user.name = nickname
            signUp()
        } else {
            showToast(message: "닉네임 중복확인을 해주세요")
        }
    }
}

// MARK: - Extensions
extension SetNickNameVIewController {
    
    // 닉네임 중복 검사 서버 통신 함수
    func checkUsername() {
        guard let nickname = nickname else { return }
        SignAPI.shared.checkUsername(nickname: nickname, completion: {(result) in
            switch result {
            case .success:
                self.showToast(message: "사용 가능한 닉네임이에요")
                self.isDuplicationChecked = true
            case .requestErr:
                self.showToast(message: "이미 사용중인 닉네임이에요")
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        })
    }
    
    // 회원가입 서버 통신 함수
    func signUp() {
        guard let email = user.email else { return }
        guard let password = user.password else { return }
        guard let name = user.name else { return }
        
        SignAPI.shared.signUp(email: email,
                              password: password,
                              name: name,
                              completion: {(result) in
            switch result {
            case .success(let data):
                guard let data = data as? SignUpResult else { return }
                // 데이터 전달
                self.userDefaults.set(data.user?.username, forKey: "username")
                self.userDefaults.set(data.accesstoken, forKey: "accessToken")
                // 화면 전환 -> 회원가입 완료
                self.navigationController?.pushViewController(CompleteSignUpViewController.instanceFromNib(), animated: true)
            case .requestErr(let message):
                print("requestErr", message)
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
