//
//  AddPillSecondView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/04/29.
//

import UIKit

import FSCalendar
import SnapKit
import Then

final class AddPillSecondView: BaseView {
    
    let navigationView = NavigationView()
    
    let pillQuestionLabel = UILabel().then {
        $0.text = "언제까지 먹는 약인가요?"
        $0.textColor = Color.gray800
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
    }
    
    lazy var pillPeriodLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardRegular, ofSize: 17)
        $0.textColor = Color.darkMint
        $0.text = "2022.1.9 ~ 2022.4.9"
    }
    
    let calendar = FSCalendar()
    
    let checkBoxButton = UIButton().then {
        $0.setImage(Image.icCheckButton48, for: .normal)
    }
    
    let startThreeMonthLabel = UILabel().then {
        $0.text = "시작일로부터 3개월"
        $0.font = UIFont.font(.pretendardRegular, ofSize: 16)
        $0.textColor = Color.black
    }
    
    let periodInformationLabel = UILabel().then {
        $0.text = "최대 3개월까지 복약 기간을 설정할 수 있어요"
        $0.textColor = Color.gray500
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
    }
    
    let nextButton = SobokButton.init(frame: CGRect(), mode: .inactive, text: "다음", fontSize: 18)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hideBottomView()
    }
    
    private func hideBottomView() {
        navigationView.bottomThirdView.isHidden = true
    }
    
    override func setupView() {
        [navigationView, pillQuestionLabel, pillPeriodLabel, calendar, checkBoxButton, startThreeMonthLabel, periodInformationLabel, nextButton].forEach {
            addSubview($0)
        }
    }
    
    override func setupConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        pillQuestionLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(35)
            $0.leading.equalToSuperview().inset(20)
        }
        
        pillPeriodLabel.snp.makeConstraints {
            $0.top.equalTo(pillQuestionLabel.snp.bottom).offset(4)
            $0.leading.equalTo(pillQuestionLabel.snp.leading)
        }
        
        calendar.snp.makeConstraints {
            $0.top.equalTo(pillPeriodLabel.snp.bottom).offset(34)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(UIScreen.main.bounds.height * 0.4)
        }
        
        checkBoxButton.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom).offset(24)
            $0.leading.equalToSuperview().inset(12)
            $0.width.height.equalTo(40)
        }
        
        startThreeMonthLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkBoxButton)
            $0.leading.equalTo(checkBoxButton.snp.trailing)
        }
        
        periodInformationLabel.snp.makeConstraints {
            $0.leading.equalTo(pillQuestionLabel.snp.leading)
            $0.top.equalTo(checkBoxButton.snp.bottom)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(22)
            $0.height.equalTo(54)
        }
    }
}
