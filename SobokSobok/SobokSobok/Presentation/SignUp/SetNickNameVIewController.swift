//
//  SetNickNameVIewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/14.
//

import UIKit

final class SetNickNameVIewController: BaseViewController {

    // MARK: Properties
    private var isNickNameRight: Bool = false
    
    // MARK: @IBOutlet Properties
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var nickNameTextFieldView: UIView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var checkDuplicationButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var warningTextLabel: UILabel!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nickNameTextField.addTarget(self, action: #selector(self.checkTextField), for: .editingChanged)
    }
    
    override func style() {
        warningTextLabel.isHidden = true
        signUpButton.isEnabled = false
        nickNameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        
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
        if nickNameTextField.text?.count ?? 0 > 10 {
                nickNameTextField.deleteBackward()
            }
        isNickNameRight = checkNickNameRight(input: nickNameTextField.text ?? "")
        warningTextLabel.isHidden = isNickNameRight || !nickNameTextField.hasText
        nickNameTextFieldView.layer.borderColor = isNickNameRight || !nickNameTextField.hasText ? Color.gray300.cgColor : Color.pillColorRed.cgColor
    }
    
    // MARK: @IBAction Properties
    @IBAction func touchUpToCheckDuplication(_ sender: Any) {
        print("닉네임중복확인")
    }
    
    @IBAction func touchUpToSignUp(_ sender: Any) {
        print("닉네임 : \(nickNameTextField.text ?? "" )")
    }
    
}
