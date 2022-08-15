//
//  EditPillPeriodView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/12.
//

import UIKit

import SnapKit
import Then

class EditPillPeriodView: BaseView {
    
    lazy var periodLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
        $0.textColor = Color.gray800
        $0.text = "약 먹는 주기"
    }
    
    var specific: Specific?

    lazy var everydayButton = SpecificButton(specific: .everyday)
    lazy var specificDayButton = SpecificButton(specific: .day)
    lazy var specificPeriodButton = SpecificButton(specific: .period)
    lazy var specificView = SpecificView().then {
        $0.makeRoundedWithBorder(radius: 8, color: Color.gray300.cgColor)
    }
    
    lazy var horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 10
    }
    
    lazy var verticalStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 10
    }
    
    convenience init(specific: Specific) {
           self.init()
           self.specific = specific
    }

    override func setupView() {
        [horizontalStackView, verticalStackView, periodLabel, everydayButton, specificDayButton, specificPeriodButton, specificView].forEach {
            addSubview($0)
        }
        
        [everydayButton, specificDayButton, specificPeriodButton].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
        
        [periodLabel, horizontalStackView, specificView].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }
    
    override func setupConstraints() {
        periodLabel.snp.makeConstraints {
            $0.top.equalTo(verticalStackView)
            $0.leading.equalTo(verticalStackView.snp.leading)
            $0.height.equalTo(48)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.top.equalTo(periodLabel.snp.bottom)
            $0.leading.trailing.equalTo(verticalStackView)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        everydayButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        specificDayButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        specificPeriodButton.snp.makeConstraints {
            $0.height.equalTo(48)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        specificView.snp.makeConstraints {
            $0.top.equalTo(horizontalStackView.snp.bottom).inset(-10)
            $0.leading.trailing.equalTo(verticalStackView)
            $0.height.equalTo(54)
        }
    }
}
