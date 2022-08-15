//
//  StopPillView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/15.
//

import UIKit

import SnapKit
import Then

final class StopPillView: BaseView {
    lazy var backgroundView = UIView().then {
        $0.makeRounded(radius: 15)
        $0.backgroundColor = Color.white
    }
    
    lazy var infoLabel = UILabel().then {
        $0.text = "약 추가를 중단하나요? \n 입력한 내용은 저장되지 않아요"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = UIFont.font(.pretendardMedium, ofSize: 16)
        $0.textColor = Color.gray900
    }
    
    lazy var horizonSeparatorLine = UIView().then {
        $0.backgroundColor = Color.gray200
    }
    
    lazy var verticalSeparatorLine = UIView().then {
        $0.backgroundColor = Color.gray200
    }
    
    lazy var continueButton = UIButton().then {
        $0.setTitle("계속할래요", for: .normal)
        $0.setTitleColor(Color.gray500, for: .normal)
    }
    
    lazy var stopButton = UIButton().then {
        $0.setTitle("중단할래요", for: .normal)
        $0.setTitleColor(Color.darkMint, for: .normal)
    }
    
    override func setupView() {
        [backgroundView, infoLabel, horizonSeparatorLine, verticalSeparatorLine, continueButton, stopButton]
            .forEach { addSubview($0) }
    }
    
    override func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.height.equalTo(166)
            $0.width.equalTo(283)
            $0.centerX.centerY.equalToSuperview()
        }
        
        infoLabel.snp.makeConstraints {
            $0.centerX.equalTo(backgroundView.snp.centerX)
            $0.top.equalTo(backgroundView.snp.top).inset(30)
        }
        
        horizonSeparatorLine.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 90)
            $0.height.equalTo(1)
            $0.top.equalTo(verticalSeparatorLine.snp.top)
            $0.leading.equalTo(backgroundView.snp.leading)
        }
        
        continueButton.snp.makeConstraints {
            $0.leading.equalTo(backgroundView.snp.leading)
            $0.width.equalTo(142)
            $0.bottom.equalTo(backgroundView.snp.bottom)
            $0.height.equalTo(55)
        }
        
        stopButton.snp.makeConstraints {
            $0.trailing.equalTo(backgroundView.snp.trailing)
            $0.width.equalTo(142)
            $0.bottom.equalTo(backgroundView.snp.bottom)
            $0.height.equalTo(55)
        }
        
        verticalSeparatorLine.snp.makeConstraints {
            $0.width.equalTo(1)
            $0.height.equalTo(55)
            $0.bottom.equalTo(backgroundView.snp.bottom)
            $0.leading.equalTo(continueButton.snp.trailing)
            $0.trailing.equalTo(stopButton.snp.leading)
        }
    }
}
