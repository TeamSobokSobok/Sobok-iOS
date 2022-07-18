//
//  NoFriendView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/20.
//

import UIKit

import SnapKit
import Then

class NoFriendView: BaseView {
    
    lazy var navigationView = NavigationView()
    
    lazy var noFriendImage = UIImageView().then {
        $0.image = Image.icNoFriend
    }
    
    lazy var noFriendLabel = UILabel().then {
        $0.text = "전송할 수 있는 사람이 없어요!"
        $0.textColor = Color.gray900
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 18)
    }
    
    lazy var addFriendLabel = UILabel().then {
        $0.text = "약을 전송할 소중한 사람을 추가해 볼까요?"
        $0.textColor = Color.gray500
        $0.font = UIFont.font(.pretendardRegular, ofSize: 16)
    }
    
    lazy var addButton = SobokButton(frame: CGRect(), mode: .mainMint, text: "추가하기", fontSize: 18)
    
    override func setupView() {
        [navigationView.cancelButton, navigationView.bottomFirstView, navigationView.bottomSecondView, navigationView.bottomThirdView].forEach {
            $0.isHidden = true
        }
        
        navigationView.xButton.setImage(Image.icClose48, for: .normal)
    
        addSubviews(navigationView, noFriendImage, noFriendLabel, addFriendLabel, addButton)
    }
    
    override func setupConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(55)
        }
        
        noFriendImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.82)
        }
        
        noFriendLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(noFriendImage.snp.bottom).offset(22)
        }
        
        addFriendLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(noFriendLabel.snp.bottom).offset(12)
        }
        
        addButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(22)
            $0.height.equalTo(54)
        }
    }
    
}
