//
//  TakePillTimeCollectionViewCell.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/05/10.
//

import UIKit

import SnapKit
import Then

final class TakePillTimeCollectionViewCell: UICollectionViewCell {
    
    lazy var timeLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardRegular, ofSize: 17)
        $0.textColor = Color.gray800
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(timeLabel)
    }
    
    private func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
