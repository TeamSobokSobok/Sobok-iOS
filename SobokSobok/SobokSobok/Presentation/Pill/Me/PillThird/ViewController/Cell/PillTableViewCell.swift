//
//  PillTableViewCell.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/05/10.
//

import UIKit

import SnapKit
import Then

final class PillTableViewCell: UITableViewCell {
    
    lazy var colorImage = UIImageView().then {
        $0.image = Image.circleRed
        $0.contentMode = .scaleToFill
    }
    
    lazy var pillLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardRegular, ofSize: 17)
        $0.textColor = Color.gray800
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentView.addSubviews(colorImage, pillLabel)
    }
    
    private func setupConstraints() {
        colorImage.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.width.height.equalTo(6)
        }
        
        pillLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(colorImage.snp.trailing).offset(19)
        }
    }
}
