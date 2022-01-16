//
//  SetNickNameVIewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/14.
//

import UIKit

import SnapKit

final class SetNickNameVIewController: BaseViewController {

    // MARK: Properties
    private var isNickNameRight: Bool = false
    private var isKeyboardOn: Bool = false
    private var keyboardHeight: CGFloat = 0
    
    // MARK: @IBOutlet Properties
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var nickNameTextFieldView: UIView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var checkDuplicationButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var warningTextLabel: UILabel!
    @IBOutlet weak var checkDuplicationButtonBottomLine: UIView!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nickNameTextField.addTarget(self, action: #selector(self.checkTextField), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
     }
    
    override func style() {
        nickNameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)

        // 초기 세팅
        warningTextLabel.isHidden = true
        [checkDuplicationButton, signUpButton].forEach({$0?.isEnabled = false})
        
        // 네비게이션바 세팅
        title = "프로필 입력"
        let backButton = UIBarButtonItem()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        backButton.title = ""
        backButton.tintColor = .black
    }
    
    // MARK: Functions
    private func checkNickNameRight (input: String) -> Bool {
        // 닉네임 조건 : [영문, 한글, 공백, 숫자] 2~10글자
        let validNickName = "[가-힣0-9a-zA-Z ]{2,10}"
        let nickNameTest = NSPredicate(format: "SELF MATCHES %@", validNickName)
          return nickNameTest.evaluate(with: input)
    }
    
    @objc private func checkTextField() {
        // 글자수 제한
        if nickNameTextField.text?.count ?? 0 > 10 {
                nickNameTextField.deleteBackward()
            }
        
        // 정규식 검사
        isNickNameRight = checkNickNameRight(input: nickNameTextField.text ?? "")
        
        // 조건에 따라 경고문 보여주기
        warningTextLabel.isHidden = isNickNameRight || !nickNameTextField.hasText
        nickNameTextFieldView.layer.borderColor = isNickNameRight || !nickNameTextField.hasText ? Color.gray300.cgColor : Color.pillColorRed.cgColor
        
        // 조건에 따라 버튼 활성화
        [signUpButton, checkDuplicationButton].forEach({$0?.isEnabled = isNickNameRight})
        checkDuplicationButtonBottomLine.backgroundColor = isNickNameRight ? UIColor(cgColor: Color.darkMint.cgColor) : UIColor(cgColor: Color.gray500.cgColor)
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
    
    // MARK: @IBAction Properties
    @IBAction func touchUpToCheckDuplication(_ sender: Any) {
        showToast(message: "dhkdhkd", iskeyboardOn: isKeyboardOn, keyboardHeight: keyboardHeight)
    }
    
    @IBAction func touchUpToSignUp(_ sender: Any) {
        print("닉네임 : \(nickNameTextField.text ?? "" )")
    }
    
    func showToast(message: String) {
        // 선언
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
}
