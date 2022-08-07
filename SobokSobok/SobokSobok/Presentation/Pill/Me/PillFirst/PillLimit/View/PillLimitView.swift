//
//  PillLimitView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/20.
//

import UIKit

import SnapKit
import Then

class PillLimitView: UIView {
    
    let navigationTitleLabel = UILabel().then {
        $0.text = "내 약 추가하기"
        $0.font = UIFont.font(.pretendardRegular, ofSize: 17)
    }
    
    let xButton = UIButton().then {
        $0.setImage(Image.icClose48, for: .normal)
        $0.tintColor = Color.black
    }
    
    let pillImageView = UIImageView().then {
        $0.image = Image.illustAlreadyFivePills
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUI() {
        [navigationTitleLabel, xButton, pillImageView].forEach {
            addSubview($0)
        }
    }
    
    func setConstraints() {
        navigationTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).inset(13)
            $0.height.equalTo(24)
        }
        
        xButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide).inset(1)
            $0.centerY.equalTo(navigationTitleLabel)
            $0.height.equalTo(48)
            $0.width.equalTo(48)
        }
        
        pillImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
