//
//  EditFriendNameViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/20.
//

import UIKit

final class EditFriendNameViewController: UIViewController {

    // MARK: - Properties
    var name: String?
    private var nameCount: Int = 0
    
    // MARK: - @IBOulet Properties
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var nameTextFieldView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var warningTextLabel: UILabel!
    @IBOutlet weak var counterTextLabel: UILabel!
    
    // MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSelector()
        layout()
    }
    
    private func layout() {
        nameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray600.cgColor)
        warningTextLabel.isHidden = true
        counterTextLabel.isHidden = true
    }
    
    // MARK: - Functions
    private func setSelector() {
        nameTextField.addTarget(self, action: #selector(self.checkTextField), for: .editingChanged)
    }

    @objc private func checkTextField() {
        // 글자수 카운트
        nameCount = nameTextField.text?.count ?? 0
        counterTextLabel.text = "\(nameCount) / 10"

        // 글자수 제한
        if nameCount > 10 {
            nameTextField.deleteBackward()
        }

        // 조건 분기처리
        if !nameTextField.hasText {
            setWithNoneText()
        } else if !checkIsIncludeSpecial(input: nameTextField.text ?? "") {
            warningTextLabel.text = "특수문자 입력은 불가능해요"
            setWarningVisible()
        } else if nameCount < 2 {
            warningTextLabel.text = "2자 이상 입력 가능해요"
            setWarningVisible()
        } else {
            setConfirmEnable()
        }
    }
    
    // 글자가 없을 때
    private func setWithNoneText() {
        nameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        counterTextLabel.isHidden = true
        warningTextLabel.isHidden = true
        confirmButton.isEnabled = false
    }

    // 경고 세팅
    private func setWarningVisible() {
        nameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.pillColorRed.cgColor)
        warningTextLabel.isHidden = false
        counterTextLabel.isHidden = false
        counterTextLabel.textColor = UIColor(cgColor: Color.pillColorRed.cgColor)
        confirmButton.isEnabled = false
    }

    // 조건 맞을 때
    private func setConfirmEnable() {
        nameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray600.cgColor)
        warningTextLabel.isHidden = true
        counterTextLabel.textColor = UIColor(cgColor: Color.gray600.cgColor)
        confirmButton.isEnabled = true
    }

    // 정규식 체크
    private func checkIsIncludeSpecial (input: String) -> Bool {
        let validName = "[A-Za-z가-힣0-9ㄱ-ㅎㅏ-ㅣ]{1,10}"
        let nameTest = NSPredicate(format: "SELF MATCHES %@", validName)
        return nameTest.evaluate(with: input)
    }
    
    // MARK: - @IBAction Properties
    @IBAction func touchUpToConfirm(_ sender: Any) {
        EditFriend.shared.groupId = 31 // 화면 연결되면 전달 받아야함
        EditFriend.shared.memberName = nameTextField.text ?? ""
        editFriendName()
    }
    
    @IBAction func touchUpToDIsmiss(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension EditFriendNameViewController {
    func editFriendName() {
        guard let groupId = EditFriend.shared.groupId else { return }
        guard let memberName = EditFriend.shared.memberName else { return }
        
        ShareAPI.shared.editFriendUsername(groupId: groupId, memberName: memberName, completion: {(result) in
            switch result {
            case .success:
                self.dismiss(animated: true)
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
