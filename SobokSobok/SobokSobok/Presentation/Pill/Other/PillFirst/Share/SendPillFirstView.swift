//
//  SendPillFirstView.swift.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/20.
//

import UIKit

import SnapKit
import Then

class SendPillFirstView: BaseView {
    lazy var navigationView = NavigationView()
    
    lazy var sendFriendLabel = UILabel().then {
        $0.text = "누구에게 전송할까요?"
        $0.textColor = Color.gray800
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
    }
    
    lazy var nextButton = SobokButton(frame: CGRect(), mode: .mainMint, text: "다음", fontSize: 18)
    
    override func setupView() {
        [navigationView.cancelButton, navigationView.bottomFirstView, navigationView.bottomSecondView, navigationView.bottomThirdView, navigationView.sendBottomSecondView, navigationView.sendBottomThirdView, navigationView.sendBottomFourthView].forEach {
            $0.isHidden = true
        }
        
    
        addSubviews(navigationView, sendFriendLabel, nextButton)

    }
    
    override func setupConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
     
        sendFriendLabel.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(27)
            $0.leading.equalToSuperview().inset(20)
        }
        
        nextButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(22)
            $0.height.equalTo(54)
        }
    }
}

