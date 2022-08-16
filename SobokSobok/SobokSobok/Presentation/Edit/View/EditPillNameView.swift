//
//  EditPillNameView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/12.
//

import UIKit

import SnapKit
import Then

class EditPillNameView: BaseView {
    
    lazy var pillNameLabel = UILabel().then {
        $0.text = "약 이름"
        $0.textColor = Color.gray800
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
    }
    
    lazy var pillNameTextField = UITextField().then {
        $0.addLeftPadding()
        $0.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
    }
    
    lazy var pillNameCountLabel = UILabel().then {
        $0.textColor = Color.gray600
        $0.font = UIFont.font(.pretendardMedium, ofSize: 13)
        $0.text = "0 / 10"
    }
    
    lazy var deleteTextButton = UIButton().then {
        $0.setImage(Image.icTextClose48, for: .normal)
    }
    
    lazy var errorLabel = UILabel().then {
        $0.text = "약 이름을 입력해 주세요"
        $0.textColor = Color.pillColorRed
        $0.font = UIFont.font(.pretendardMedium, ofSize: 13)
    }
    
    override func setupView() {
        [pillNameLabel, pillNameTextField, pillNameCountLabel, deleteTextButton, errorLabel].forEach {
            addSubview($0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        assignDelegation()
        errorLabel.isHidden = true
        deleteTextButton.isHidden = true
    }
    
    private func assignDelegation() {
        pillNameTextField.delegate = self
    }
    
    private func setupTextField() {
        pillNameTextField.addTarget(self, action: #selector(pillTextFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    @objc func pillTextFieldDidChange(_ textField: UITextField) {
        guard let text = pillNameTextField.text else { return }
        
        pillNameTextField.attributedText = setAttributedText(text: text)
        
        pillNameCountLabel.attributedText = setAttributedText(text: "\(String(text.count)) / 10")
        
        if text.count == 0 {
            pillNameCountLabel.isHidden = true
            pillNameTextField.layer.borderColor = Color.pillColorRed.cgColor
            errorLabel.isHidden = false
            deleteTextButton.isHidden = true
        } else {
            pillNameCountLabel.isHidden = false
            pillNameTextField.layer.borderColor = Color.gray600.cgColor
            errorLabel.isHidden = true
            deleteTextButton.isHidden = false
        }
    }
    
    func setAttributedText(text: String) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: "/ 10자"))
        return attributeString
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let medicineText = pillNameTextField.text ?? ""
            guard let stringRange = Range(range, in: medicineText) else { return false }
            let updatedText = medicineText.replacingCharacters(in: stringRange, with: string)
            return updatedText.count <= 10
    }
    
    override func setupConstraints() {
        pillNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        pillNameTextField.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(pillNameLabel.snp.bottom).offset(10)
            $0.height.equalTo(54)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        pillNameCountLabel.snp.makeConstraints {
            $0.top.equalTo(pillNameTextField.snp.bottom).offset(3)
            $0.trailing.equalTo(pillNameTextField.snp.trailing).inset(10)
        }
        
        deleteTextButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.centerY.equalTo(pillNameTextField.snp.centerY)
            $0.trailing.equalTo(pillNameTextField.snp.trailing).offset(3)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(pillNameTextField.snp.bottom).offset(3)
            $0.leading.equalTo(pillNameTextField.snp.leading).inset(10)
        }
    }
}

extension EditPillNameView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        pillNameTextField.layer.borderColor = Color.gray300.cgColor
        deleteTextButton.isHidden = true
        errorLabel.isHidden = true
    }
}
