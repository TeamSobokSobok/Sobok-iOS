//
//  AddPillThirdView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/04/30.
//

import UIKit

import SnapKit
import Then

final class AddPillThirdView: BaseView {
    
    let navigationView = NavigationView()
    
    let pillNameInfoLabel = UILabel().then {
        $0.text = "약 이름을 입력해 주세요"
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
        $0.textColor = Color.gray800
    }
    
    let pillPeriodInfoLabel = UILabel().then {
        $0.text = "같은 주기에 먹는 약을 함께 추가할 수 있어요."
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.textColor = Color.gray500
    }
    
    let pillCountLabel = UILabel().then {
        $0.text = "3개"
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.textColor = Color.darkMint
    }
    
    lazy var pillCountInfoLabel = UILabel().then {
        $0.text = "더 추가할 수 있어요"
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.textColor = Color.gray500
    }
    
    let countInfoButton = UIButton()
    
    let pillCollectionView = UICollectionView()
    
    let nextButton = SobokButton.init(frame: CGRect(), mode: .inactive, text: "추가하기", fontSize: 18)

    override func setupView() {
        addSubviews(navigationView, nextButton)
        }
    
    
override func setupConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
      
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(22)
            $0.height.equalTo(54)
        }
    }

}
