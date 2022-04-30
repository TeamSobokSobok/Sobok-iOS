//
//  PillInfoView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/02/24.
//

import UIKit

import SnapKit
import Then

final class PillInfoView: BaseView {
    
    // MARK: - Properties
    private let navigationView = NavigationHeaderView.init(frame: CGRect(), mode: .back, title: "약 일정")
    let titleLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardBold, ofSize: 24)
        $0.textColor = Color.gray900
    }
    private let lineView = UIView().then {
        $0.backgroundColor = Color.gray200
    }
    private let termTitleLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 16)
        $0.text = "약 먹는 주기"
        $0.textColor = Color.black
    }
    private let weekButton = UIButton().then {
        $0.backgroundColor = Color.lightMint
        $0.isEnabled = false
        $0.makeRoundedWithBorder(radius: 6, color: Color.darkMint.cgColor)
        $0.setTitle("특정 요일", for: .normal)
        $0.setTitleColor(Color.darkMint, for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: 18)
    }
    let weekLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 18)
        $0.textColor = Color.gray800
    }
    private let termStack = UIStackView().then {
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.spacing = 12
    }
    private let timeTitleLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 16)
        $0.text = "약 먹는 시간"
        $0.textColor = Color.black
    }
    let timeFirstLine = UIStackView().then {
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.spacing = 10
    }
    let timeSecondLine = UIStackView().then {
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.spacing = 10
    }
    private let periodTitleLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 16)
        $0.text = "약 먹는 기간"
        $0.textColor = Color.black
    }
    let periodLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 18)
        $0.textColor = Color.darkMint
    }
    private let periodStack = UIStackView().then {
        $0.alignment = .fill
        $0.axis = .vertical
        $0.spacing = 7
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()
        
        addSubviews(navigationView, titleLabel, lineView, termTitleLabel, termStack, timeTitleLabel, timeFirstLine, timeSecondLine, periodStack)
        termStack.addArrangedSubviews(weekButton, weekLabel)
        periodStack.addArrangedSubviews(periodTitleLabel, periodLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        navigationView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(19)
            make.leading.equalToSuperview().offset(20)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(13)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(UIScreen.main.bounds.width - 20)
            make.height.equalTo(1)
        }
        termTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(20)
        }
        weekButton.snp.makeConstraints { make in
            make.width.equalTo(95)
            make.height.equalTo(38)
        }
        termStack.snp.makeConstraints { make in
            make.top.equalTo(termTitleLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(20)
        }
        timeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(termStack.snp.bottom).offset(39)
            make.leading.equalToSuperview().offset(20)
        }
        timeFirstLine.snp.makeConstraints { make in
            make.top.equalTo(timeTitleLabel.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(UIScreen.main.bounds.width - 20)
            make.height.equalTo(38)
        }
        timeSecondLine.snp.makeConstraints { make in
            make.top.equalTo(timeFirstLine.snp.bottom).offset(9)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(UIScreen.main.bounds.width - 20)
            make.height.equalTo(38)
        }
        periodStack.snp.makeConstraints { make in
            make.top.equalTo(timeTitleLabel.snp.bottom).offset(143)
            make.leading.equalTo(20)
        }
    }
}
