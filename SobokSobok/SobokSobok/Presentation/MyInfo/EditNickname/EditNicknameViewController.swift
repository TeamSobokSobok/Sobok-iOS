//
//  EditNicknameViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/07/21.
//

import UIKit

protocol EditNicknameProtocol: StyleProtocol {}

final class EditNicknameViewController: UIViewController, EditNicknameProtocol {

    // MARK: - Properties
    var nickname: String?
    let editNicknameManager: AccountServiceable = AccountManager(apiService: APIManager(), environment: .development)

    private var isNickNameRight: Bool = false
    private var isDuplicationChecked: Bool = false
    
    private var isKeyboardOn: Bool = false
    private var keyboardHeight: CGFloat = 0
    
    // MARK: - @IBOulet Properties
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var nickNameTextFieldView: UIView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var warningTextLabel: UILabel!
    @IBOutlet weak var checkDuplicationButton: UIButton!
    @IBOutlet weak var checkDuplicationButtonBottomLine: UIView!
    
    
    // MARK: - Life Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        addTargetToTextField()
    }
    
    func style() {
        navigationController?.navigationBar.isHidden = true
        nickNameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        warningTextLabel.isHidden = true
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
        enableDuplicationCheckButton()
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

    @objc private func inactivateTextField() {
        nickNameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
    }

    // MARK: 버튼 활성화 관련
    private func enableDuplicationCheckButton() {
        checkDuplicationButton.isEnabled = isNickNameRight
        checkDuplicationButtonBottomLine.backgroundColor = isNickNameRight ? UIColor(cgColor: Color.darkMint.cgColor) : UIColor(cgColor: Color.gray400.cgColor)
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
        toastLabel.layer.cornerRadius = 8
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

    @IBAction func touchUpToCheckDuplication(_ sender: UIButton) {
        nickname = nickNameTextField.text ?? ""
        checkUsername()
    }

    @IBAction func touchUpToConfirm(_ sender: UIButton) {
        if isDuplicationChecked {
            editNickname(for: nickNameTextField.text ?? "")
        } else {
            showToast(message: "닉네임 중복확인을 해주세요")
        }
    }

    @IBAction func touchUpToDIsmiss(_ sender: UIButton) {
        dismiss(animated: true)
    }

}

// MARK: - Extensions
extension EditNicknameViewController {

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
}


