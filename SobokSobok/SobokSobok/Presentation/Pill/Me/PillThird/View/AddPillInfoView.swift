//
//  AddPillInfoView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/05/04.
//

import UIKit

import SnapKit
import Then

final class AddPillInfoView: BaseView {
    
    lazy var height: CGFloat = UIScreen.main.bounds.height
    
    lazy var backgroundView = UIView().then {
        $0.backgroundColor = UIColor.white
    }
    
    lazy var bottomSheetView = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.makeRoundedSpecificCorner([.layerMinXMinYCorner, .layerMaxXMinYCorner], cornerRadius: 24)
    }
    
    lazy var pillPeriodTimeView = PillPeriodTimeView().then {
        $0.makeRoundedSpecificCorner([.layerMinXMinYCorner, .layerMaxXMinYCorner], cornerRadius: 24)
    }
    
    lazy var pillNameView = PillNameView().then {
        $0.backgroundColor = .white
    }
    
    lazy var sendButton = SobokButton.init(frame: CGRect(), mode: .mainMint, text: "전송하기", fontSize: 18)
    
    override func setupView() {
        addSubviews(backgroundView)
        backgroundView.addSubviews(bottomSheetView, pillNameView, pillPeriodTimeView, sendButton)
//        pillPeriodTimeView.addSubview(sendButton)
        backgroundColor = .white
    }

    override func setupConstraints() {
        backgroundView.snp.makeConstraints {
            $0.height.equalTo(UIScreen.main.bounds.height * 0.1)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaInsets)
        }
     
        bottomSheetView.snp.makeConstraints {
            $0.height.equalTo(0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        pillPeriodTimeView.snp.makeConstraints {
            $0.height.equalTo((height * 0.9 - 110) / 2)
            $0.top.equalTo(bottomSheetView.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        
        pillNameView.snp.makeConstraints {
            $0.height.equalTo((height * 0.9 - 110) / 2)
            $0.top.equalTo(pillPeriodTimeView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints {
            $0.leading.equalTo(bottomSheetView.snp.leading).inset(20)
            $0.trailing.equalTo(bottomSheetView.snp.trailing).inset(20)
            $0.bottom.equalTo(bottomSheetView.snp.bottom).inset(56)
            $0.height.equalTo(54)
        }
    }
}
