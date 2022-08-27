//
//  EditPillDateView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/27.
//

import UIKit

import SnapKit
import Then

class EditPillDateView: BaseView {
    
    lazy var datePeriodLabel = UILabel().then {
        $0.text = "약 먹는 기간"
        $0.textColor = Color.gray800
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
    }
    
    lazy var noChangeLabel = UILabel().then {
        $0.text = "약 먹는 기간은 변경할 수 없어요"
        $0.textColor = Color.gray500
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
    }
    
    lazy var labelBackgroundView = UIView().then {
        $0.makeRoundedWithBorder(radius: 10, color: Color.gray150.cgColor, borderWith: 1)
    }
    
    lazy var pillDateLabel = UILabel().then {
        $0.text = "2022.1.9 ~ 2022.4.9"
        $0.textColor = Color.gray700
        $0.font = UIFont.font(.pretendardMedium, ofSize: 18)
    }
    
    override func setupView() {
        addSubviews(datePeriodLabel,
                    noChangeLabel,
                    labelBackgroundView,
                    pillDateLabel)
    }
    
    override func setupConstraints() {
        datePeriodLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        noChangeLabel.snp.makeConstraints {
            $0.top.equalTo(datePeriodLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().inset(20)
        }
        
        labelBackgroundView.snp.makeConstraints {
            $0.top.equalTo(noChangeLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(54)
        }
        
        pillDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(labelBackgroundView.snp.centerY)
            $0.leading.equalTo(labelBackgroundView.snp.leading).inset(16)
        }
    }
}
