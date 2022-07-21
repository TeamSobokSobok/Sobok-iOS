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
    
    lazy var pillNameTextField = UITextField().then {
        $0.makeRoundedWithBorder(radius: 8, color: Color.gray300.cgColor)
    }
    
    lazy var deleteCellButton = UIButton().then {
        $0.setImage(Image.icClose48, for: .normal)
        $0.tintColor = Color.gray500
    }
    
    lazy var deleteTextButton = UIButton().then {
        $0.setImage(Image.icTextClose48, for: .normal)
    }
    
    lazy var pillTextCountLabel = UILabel().then {
        $0.text = "10/10"
    }
    
    let verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 10
    }
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        setupView()
        setupConstraints()
        pillTextCountLabel.isHidden = true
        pillNameTextField.delegate = self
        print(verticalStackView.bounds.height)
        
       }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [verticalStackView].forEach {
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
        }
    }
    
}

extension AddPillCollectionViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pillTextCountLabel.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        pillTextCountLabel.isHidden = true
    }
}
