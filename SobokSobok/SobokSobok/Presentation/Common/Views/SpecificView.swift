//
//  SpecificView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/02.
//

import UIKit

import SnapKit
import Then

final class SpecificView: UIView {

    lazy var specificLabel = UILabel().then {
        $0.text = "며칠 간격으로 먹나요?"
        $0.font = UIFont.font(.pretendardMedium, ofSize: 18)
        $0.textColor = Color.gray500
    }
    
    let backgroundButton = UIButton()

    let moreButton = UIButton().then {
        $0.setImage(Image.icMore48, for: .normal)
        $0.tintColor = Color.black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        [specificLabel, backgroundButton, moreButton].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraints() {
        backgroundButton.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        specificLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
        }
        
        moreButton.snp.makeConstraints {
            $0.width.height.equalTo(48)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(3)
        }
    }
}
