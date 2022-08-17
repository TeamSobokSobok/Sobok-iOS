//
//  AddPillCommonView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/16.
//

import UIKit

import SnapKit
import Then

final class FirstPillNameView: BaseView {
    
    var timeArray: [String] = []
    
    let sendPillViewModel: SendPillViewModel
    lazy var addPillThird = AddPillThirdView()
    
    lazy var pillNameTextField = UITextField().then {
        $0.makeRoundedWithBorder(radius: 8, color: Color.gray300.cgColor)
        $0.addLeftPadding()
    }
    
    lazy var deleteCellButton = UIButton().then {
        $0.setImage(Image.icClose48, for: .normal)
        $0.tintColor = Color.gray500
    }
    
    lazy var deleteTextButton = UIButton().then {
        $0.setImage(Image.icTextClose48, for: .normal)
        $0.addTarget(self, action: #selector(deleteTextButtonTapped), for: .touchUpInside)
    }
    
    lazy var pillTextCountLabel = UILabel().then {
        $0.text = "10/10"
        $0.textColor = Color.gray600
        $0.font = UIFont.font(.pretendardMedium, ofSize: 13)
    }
    
    let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .trailing
        $0.spacing = 10
    }
    
    init(frame: CGRect, sendPillViewModel: SendPillViewModel) {
        self.sendPillViewModel = sendPillViewModel
        super.init(frame: frame)
        setupView()
        setupConstraints()
        setupTextField()
        assignDelegation()
    }

    private func assignDelegation() {
        pillNameTextField.delegate = self
    }
    
    private func setupTextField() {
        pillNameTextField.addTarget(self, action: #selector(pillTextFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }
    
    @objc func deleteTextButtonTapped() {
        self.pillNameTextField.text = ""
        self.sendPillViewModel.pillName[sendPillViewModel.tag] = ""
    }
    
    @objc func pillTextFieldDidChange(_ textField: UITextField) {
        guard let text = pillNameTextField.text else { return }
        if text.count == 0 {
            sendPillViewModel.isTrue.value = false
        } else {
            sendPillViewModel.isTrue.value = true
        }
        
        pillNameTextField.attributedText = setAttributedText(text: text)
        pillTextCountLabel.attributedText = setAttributedText(text: "\(String(text.count)) / 10")
        
        if text.count == 0 {
            pillTextCountLabel.isHidden = true
            addPillThird.footerView.isHidden = true
            
            deleteTextButton.isHidden = true
        } else {
            pillTextCountLabel.isHidden = false
            pillNameTextField.layer.borderColor = Color.gray600.cgColor
            addPillThird.footerView.isHidden = false
            deleteTextButton.isHidden = false
        }
    }
    
    func setAttributedText(text: String) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.black, range: (text as NSString).range(of: "/ 10자"))
        return attributeString
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let pillText = pillNameTextField.text ?? ""
        guard let stringRange = Range(range, in: pillText) else { return false }
        let updatedText = pillText.replacingCharacters(in: stringRange, with: string)
        return updatedText.count <= 10
    }
    
    override func setupView() {
        [verticalStackView, deleteCellButton, deleteTextButton].forEach {
            addSubview($0)
        }
        
        [pillNameTextField, pillTextCountLabel].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    override func setupConstraints() {
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        pillNameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(54)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        pillTextCountLabel.snp.makeConstraints {
            $0.height.equalTo(21)
            $0.trailing.equalTo(verticalStackView.snp.trailing).inset(10)
        }
        
        deleteCellButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.trailing.equalToSuperview().inset(3)
            $0.centerY.equalTo(pillNameTextField.snp.centerY)
        }
        
        deleteTextButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.trailing.equalToSuperview().inset(3)
            $0.centerY.equalTo(pillNameTextField.snp.centerY)
        }
    }
}

extension FirstPillNameView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if pillNameTextField.isEditing {
            pillTextCountLabel.isHidden = false
            pillNameTextField.layer.borderColor = Color.gray600.cgColor
        } else {
            pillNameTextField.layer.borderColor = Color.gray300.cgColor
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = pillNameTextField.text else { return }
        sendPillViewModel.pillName[sendPillViewModel.tag] = text
        pillTextCountLabel.isHidden = true
        deleteTextButton.isHidden = true
    }
}
