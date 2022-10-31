//
//  SetNickNameVIewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/14.
//

import UIKit
import SnapKit

protocol SetNicknameProtocol: StyleProtocol {}

final class SetNickNameVIewController: UIViewController, SetNicknameProtocol {

    private let personalInfoLink: String = "https://baejiann120.notion.site/4f976bca05bb40b49d618c745cc5b754"
     private let serviceTermsLink: String = "https://baejiann120.notion.site/77c1e0372c784f8399d1c588f2e89cef"
    
    // MARK: - Properties
    private var user = SignUpUserData.shared
    private let userDefaults = UserDefaults.standard
    var nickname: String?
    
    private var isNickNameRight: Bool = false
    private var isDuplicationChecked: Bool = false
    
    private var isFirstAgreed: Bool = false
    private var isSecondAgreed: Bool = false
    
    private var isKeyboardOn: Bool = false
    private var keyboardHeight: CGFloat = 0
    
    var socialId: String?
    lazy var authManager = AuthManager(apiService: APIManager(), environment: .development)
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var nickNameTextFieldView: UIView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var checkDuplicationButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var warningTextLabel: UILabel!
    @IBOutlet weak var checkDuplicationButtonBottomLine: UIView!
    
    @IBOutlet weak var firstTerm: UIView!
    @IBOutlet weak var secondTerm: UIView!
    @IBOutlet weak var thirdTerm: UIView!
    
    @IBOutlet weak var agreeAllButton: UIButton!
    @IBOutlet weak var agreeFirstButton: UIButton!
    @IBOutlet weak var agreeSecondButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargetToTextField()
        style()
    }
    
    func style() {
        navigationController?.navigationBar.isHidden = true
        nickNameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        warningTextLabel.isHidden = true
        signUpButton.makeRounded(radius: 12)
        
        // 약관 동의 테두리
        firstTerm.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        firstTerm.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        secondTerm.makeRoundedWithBorder(radius: 0, color: Color.gray300.cgColor, borderWith: 1)
        
        thirdTerm.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        thirdTerm.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
    }
    
    // MARK: Functions
    private func addTargetToTextField() {
        nickNameTextField.addTarget(self, action: #selector(self.activateTextField), for: .editingDidBegin)
        nickNameTextField.addTarget(self, action: #selector(self.changeTextFieldDuringEditing), for: .editingChanged)
        nickNameTextField.addTarget(self, action: #selector(self.inactivateTextField), for: .editingDidEnd)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: 텍스트필드 관련
    @objc private func activateTextField() {
        changeTextFieldBorder()
    }
    @objc private func changeTextFieldDuringEditing() {
        initializeDuplicationCheck()
        limitNicknameText()
        checkIsNicknameRight()
        showWarning()
        changeTextFieldBorder()
        enableDuplicationCheckButton()
        enableSignUpButton()
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
    
    // MARK: 텍스트필드 스타일 관련
    private func showWarning() {
        warningTextLabel.isHidden = isNickNameRight || !nickNameTextField.hasText
    }
    private func changeTextFieldBorder() {
        nickNameTextFieldView.layer.borderColor = isNickNameRight || !nickNameTextField.hasText ? Color.gray600.cgColor : Color.pillColorRed.cgColor
    }
    
    @objc private func inactivateTextField() {
        warningTextLabel.isHidden = isNickNameRight || !nickNameTextField.hasText
        nickNameTextFieldView.layer.borderColor = isNickNameRight || !nickNameTextField.hasText ? Color.gray300.cgColor : Color.pillColorRed.cgColor
    }
    
    // MARK: 버튼 활성화 관련
    private func enableDuplicationCheckButton() {
        checkDuplicationButton.isEnabled = isNickNameRight
        checkDuplicationButtonBottomLine.backgroundColor = isNickNameRight ? UIColor(cgColor: Color.darkMint.cgColor) : UIColor(cgColor: Color.gray400.cgColor)
    }
    private func enableSignUpButton() {
        signUpButton.isEnabled = isNickNameRight && isFirstAgreed && isSecondAgreed
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
    @IBAction func touchUpToDismiss(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpToCheckDuplication(_ sender: UIButton) {
        nickname = nickNameTextField.text ?? ""
        checkUsername()
    }
    
    // MARK: 약관 동의 관련
    @IBAction func touchUpToAgreeAll(_ sender: UIButton) {
        isFirstAgreed = true
        isSecondAgreed = true
        checkTermButtons()
        enableSignUpButton()
    }
    @IBAction func touchUpToAgreeFirst(_ sender: UIButton) {
        isFirstAgreed.toggle()
        checkTermButtons()
        enableSignUpButton()
    }
    @IBAction func touchUpToAgreeSecond(_ sender: UIButton) {
        isSecondAgreed.toggle()
        checkTermButtons()
        enableSignUpButton()
    }
    private func checkTermButtons() {
        agreeAllButton.setImage( isFirstAgreed && isSecondAgreed ? UIImage(named: "icChecked") : UIImage(named: "icCheckedNot"), for: .normal)
        agreeFirstButton.setImage( isFirstAgreed ? UIImage(named: "icChecked") : UIImage(named: "icCheckedNot"), for: .normal)
        agreeSecondButton.setImage( isSecondAgreed ? UIImage(named: "icChecked") : UIImage(named: "icCheckedNot"), for: .normal)
    }
    
    // 링크 연결
    private func openSafari(link: String) {
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func openPersonalInfo(_ sender: UIButton) {
        openSafari(link: personalInfoLink)
    }
    
    @IBAction func openServicePolicy(_ sender: UIButton) {
        openSafari(link: serviceTermsLink)
    }
    
    
    // 회원가입
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
        Task {
            guard let socialId = socialId else { return }
            guard let nickname = nickname else { return }
            let deviceToken = UserDefaultsManager.fcmToken
            
            let result = try await authManager.signUp(
                socialId: socialId,
                username: nickname,
                deviceToken: deviceToken
            )
            
            print(result?.accesstoken)

            if result?.isNew != nil {
                guard let accesstoken = result?.accesstoken else { return }
                UserDefaultsManager.accessToken = accesstoken
                UserDefaultsManager.userName = nickname
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                    self?.transitionToCompleteSignUpViewController()
                }

            } else {
                print("회원가입 실패 또는 이미 있는 유저")
            }
        }
    }
    
    func transitionToCompleteSignUpViewController() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let completeSignUpViewController = CompleteSignUpViewController.instanceFromNib()
        sceneDelegate?.window?.rootViewController = UINavigationController(rootViewController: completeSignUpViewController)
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
