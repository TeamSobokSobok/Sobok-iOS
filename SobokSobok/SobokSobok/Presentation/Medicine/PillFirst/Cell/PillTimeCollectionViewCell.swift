//
//  PillTimeCollectionViewCell.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/02.
//

import UIKit

import SnapKit
import Then

final class PillTimeCollectionViewCell: UICollectionViewCell {
    
    lazy var timeLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 18)
        $0.textColor = Color.black
        $0.text = "오전 8:00"
    }
    
    lazy var deleteButton = UIButton().then {
        $0.setImage(Image.icPlusActive, for: .normal)
    }
    
    override init(frame: CGRect) {
           super.init(frame: frame)
        setUI()
        setConstraints()
        contentView.makeRoundedWithBorder(radius: 8, color: Color.darkMint.cgColor)
       }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        [timeLabel, deleteButton].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraints() {
        timeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        deleteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(3)
            $0.width.height.equalTo(48)
        }
    }
}
