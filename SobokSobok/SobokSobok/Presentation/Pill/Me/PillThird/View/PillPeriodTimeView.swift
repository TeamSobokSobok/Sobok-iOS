//
//  PillPeriodTimeView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/05/04.
//

import UIKit

import SnapKit
import Then

final class PillPeriodTimeView: BaseView {
    
    lazy var pillPeopleLabel = UILabel().then {
        $0.textColor = Color.black
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 22)
    }
    
    lazy var pillPeriodLabel = UILabel().then {
        $0.text = "약 먹는 주기"
        $0.textColor = Color.black
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
    }
    
    lazy var pillBackgroundView = UIView().then {
        $0.backgroundColor = Color.lightMint
        $0.makeRoundedWithBorder(radius: 6, color: Color.darkMint.cgColor)
    }
    
    lazy var pillSpecificLabel = UILabel().then {
        $0.text = "특정 주기"
        $0.font = UIFont.font(.pretendardMedium, ofSize: 17)
        $0.textColor = Color.darkMint
    }
    
    lazy var periodLabel = UILabel().then {
        $0.text = "월, 화, 수, 목, 금, 토, 일"
        $0.textColor = Color.gray800
        $0.font = UIFont.font(.pretendardRegular, ofSize: 17)
    }
    
    lazy var pillTimeLabel = UILabel().then {
        $0.text = "약 먹는 시간"
        $0.textColor = Color.black
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
    }
    
    let timeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 5, left: 2, bottom: 5, right: 2)
        
        $0.isScrollEnabled = false
        $0.collectionViewLayout = layout
        $0.register(TakePillTimeCollectionViewCell.self)
    }
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Color.white
    }
    
    override func setupView() {
        addSubviews(pillPeopleLabel, pillPeriodLabel, pillBackgroundView, pillSpecificLabel, periodLabel, pillTimeLabel, timeCollectionView)
    }
    
    override func setupConstraints() {
        pillPeopleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.3)
            $0.leading.equalToSuperview().inset(30)
        }
        
        pillPeriodLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.7)
            $0.leading.equalToSuperview().inset(30)
        }
        
        pillBackgroundView.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(0.95)
            $0.leading.equalToSuperview().inset(30)
            $0.width.equalTo(87)
            $0.height.equalTo(34)
        }
        
        pillSpecificLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(pillBackgroundView)
        }
        
        periodLabel.snp.makeConstraints {
            $0.centerY.equalTo(pillBackgroundView)
            $0.leading.equalTo(pillBackgroundView.snp.trailing).offset(13)
        }
        
        pillTimeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview().multipliedBy(1.3)
            $0.leading.equalToSuperview().inset(30)
        }
        
        timeCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.top.equalTo(pillTimeLabel.snp.bottom).offset(8)
            $0.height.equalTo(80)
        }
    }
}
