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
    
    lazy var pillNameTextField = UITextField()
    
    lazy var xButton = UIButton().then {
        $0.setImage(Image.icClose48, for: .normal)
        $0.tintColor = Color.gray500
    }
    
    override init(frame: CGRect) {
           super.init(frame: frame)

        contentView.makeRoundedWithBorder(radius: 8, color: Color.gray300.cgColor)
       }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        
    }
    
    private func setupConstraints() {
        
    }
    
}
