//
//  PillNameView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/05/04.
//

import UIKit

import SnapKit
import Then

final class PillNameView: BaseView {
    
    lazy var pillPeriodLabel = UILabel().then {
        $0.text = "약 먹는 기간"
        $0.textColor = Color.black
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
    }
    
    lazy var pillPeriodInfoLabel = UILabel().then {
        $0.text = "2022.1.9 ~ 2022.4.9"
        $0.textColor = Color.darkMint
        $0.font = UIFont.font(.pretendardRegular, ofSize: 17)
    }
    
    lazy var underLineView = UIView().then {
        $0.backgroundColor = Color.gray200
    }
    
    lazy var pillNameLabel = UILabel().then {
        $0.text = "약 이름"
        $0.textColor = Color.black
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
    }
    
    lazy var pillTableView = UITableView().then {
        $0.register(PillTableViewCell.self)
        $0.separatorStyle = .none
        $0.rowHeight = 29
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.white
    }
    
    override func setupView() {
        addSubviews(pillNameLabel, pillPeriodLabel, pillPeriodInfoLabel, underLineView, pillNameLabel, pillTableView)
    }
    
    override func setupConstraints() {
        pillPeriodLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.centerY.equalToSuperview().multipliedBy(0.3)
        }
        
        pillPeriodInfoLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(30)
            $0.top.equalTo(pillPeriodLabel.snp.bottom).offset(6)
        }
        
        underLineView.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.68)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.height.equalTo(1)
        }
        
        pillNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.83)
            $0.leading.equalToSuperview().inset(30)
        }
        
        pillTableView.snp.makeConstraints {
            $0.top.equalTo(pillNameLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.bottom.equalTo(safeAreaInsets)
        }
    }
}
