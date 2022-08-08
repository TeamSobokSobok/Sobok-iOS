//
//  AddPillCollectionViewCell.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/05/02.
//

import UIKit

import SnapKit
import Then

final class AddPillCollectionViewCell: UICollectionViewCell {
    
    let pillThirdViewModel = PillThirdViewModel()
    
    lazy var pillNameTextField = UITextField().then {
        $0.makeRoundedWithBorder(radius: 8, color: Color.gray300.cgColor)
        $0.addLeftPadding()
    }
    
    lazy var deleteCellButton = UIButton().then {
        $0.setImage(Image.icClose48, for: .normal)
        $0.tintColor = Color.gray500
        $0.addTarget(self, action: #selector(deleteCellButtonTapped), for: .touchUpInside)
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
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        setupView()
        setupConstraints()
        pillTextCountLabel.isHidden = true
        deleteCellButton.isHidden = true
        pillNameTextField.delegate = self
        setTextField()
    }
    
    private func setTextField() {
            pillNameTextField.addTarget(self, action: #selector(pillTextFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
        }
    
    @objc func pillTextFieldDidChange(_ textField: UITextField) {
        pillNameTextField.attributedText = setAttributedText(text: pillNameTextField.text!)
        
        print(pillNameTextField.text!)
        
        pillTextCountLabel.attributedText = setAttributedText(text: "\(String(pillNameTextField.text?.count ?? 0)) / 10")
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

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [verticalStackView, deleteCellButton, deleteTextButton].forEach {
            contentView.addSubviews($0)
        }
        
        [pillNameTextField, pillTextCountLabel].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    private func setupConstraints() {
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(200)
        }
        
        pillNameTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(54)
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
    
    @objc func deleteCellButtonTapped() {
        pillThirdViewModel.deleteCellClosure?()
    }
    
    @objc func deleteTextButtonTapped() {
        pillThirdViewModel.deleteCellClosure?()
    }
}

extension AddPillCollectionViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pillTextCountLabel.isHidden = false
        deleteCellButton.isHidden = true
        deleteTextButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        pillTextCountLabel.isHidden = true
        deleteCellButton.isHidden = false
        deleteTextButton.isHidden = true
    }
}
