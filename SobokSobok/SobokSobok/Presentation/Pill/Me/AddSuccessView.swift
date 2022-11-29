//
//  AddSuccessView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/10/28.
//

import UIKit

import SnapKit
import Then

final class AddSuccessView: BaseView {
    
    lazy var backgroundView = UIView().then {
        $0.makeRounded(radius: 15)
        $0.backgroundColor = Color.white
    }
    
    lazy var successLabel = UILabel().then {
        $0.text = "내 약 추가 성공! \n 홈에서 확인할 수 있어요"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = UIFont.font(.pretendardMedium, ofSize: 16)
        $0.textColor = Color.gray900
    }
    
    lazy var horizonSeparatorLine = UIView().then {
        $0.backgroundColor = Color.gray200
    }
    
    lazy var confirmButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(Color.darkMint, for: .normal)
    }
    
    override func setupView() {
        [backgroundView, successLabel, horizonSeparatorLine, confirmButton].forEach { addSubview($0) }
    }
    
    override func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.height.equalTo(166)
            $0.width.equalTo(283)
            $0.centerX.centerY.equalToSuperview()
        }
        
        successLabel.snp.makeConstraints {
            $0.centerX.equalTo(backgroundView.snp.centerX)
            $0.top.equalTo(backgroundView.snp.top).inset(36)
        }
        
        horizonSeparatorLine.snp.makeConstraints {
            $0.width.equalTo(UIScreen.main.bounds.width - 90)
            $0.height.equalTo(1)
            $0.top.equalTo(successLabel.snp.bottom).inset(-35)
            $0.leading.equalTo(backgroundView.snp.leading)
        }
      
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(horizonSeparatorLine.snp.bottom)
            $0.leading.equalTo(backgroundView.snp.leading)
            $0.trailing.equalTo(backgroundView.snp.trailing)
            $0.height.equalTo(55)
        }
    }
}
