//
//  MedicineInfoHeaderView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/17.
//

import UIKit

import SnapKit
import Then

class MedicineInfoHeaderView: UICollectionReusableView {
        
    let pillInfoLabel = UILabel().then {
        $0.text = "내가 먹을 약이에요"
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
    }
    
    let mainView = UIView().then {
        $0.backgroundColor = Color.lightMint
        $0.makeRounded(radius: 8)
    }
    
    let addPillLabel = UILabel().then {
        $0.text = "3개 더 추가할 수 있어요"
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.textColor = Color.darkMint
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUI() {
        [pillInfoLabel, mainView, addPillLabel].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraints() {
        pillInfoLabel.snp.makeConstraints {
            $0.top.equalTo(0)
            $0.leading.equalTo(20)
        }
        
        mainView.snp.makeConstraints {
            $0.top.equalTo(pillInfoLabel.snp.bottom).offset(11)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.bottom.equalTo(-11)
            $0.height.equalTo(34)
        }
        
        addPillLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(mainView)
        }
    }
    
    
}
