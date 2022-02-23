//
//  ButtonView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/02/19.
//

import UIKit

import SnapKit
import Then

final class ButtonView: UIView {
    
    private lazy var button1 = SobokButton.init(frame: CGRect(), mode: .lightMint, text: "거절", fontSize: 13)
    
    private lazy var button2 = SobokButton.init(frame: CGRect(), mode: .mainMint, text: "수락", fontSize: 13)
    
    private lazy var button3 = SobokButton.init(frame: CGRect(), mode: .lightMint, text: "거절할래요", fontSize: 18)
    
    private lazy var button4 = SobokButton.init(frame: CGRect(), mode: .mainMint, text: "받을래요", fontSize: 18)
    
    private lazy var button5 = SobokButton.init(frame: CGRect(), mode: .mainMint, text: "선택 완료", fontSize: 18)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    private func setUI() {
        [button1, button2, button3, button4, button5].forEach {
            addSubview($0)
        }
    }
    
    private func setConstraints() {
        button1.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(145)
            $0.height.equalTo(40)
        }
        
        button2.snp.makeConstraints {
            $0.top.equalTo(button1.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(145)
            $0.height.equalTo(40)
        }
        
        button3.snp.makeConstraints {
            $0.top.equalTo(button2.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(162)
            $0.height.equalTo(52)
        }
        
        button4.snp.makeConstraints {
            $0.top.equalTo(button3.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(162)
            $0.height.equalTo(52)
        }
        
        button5.snp.makeConstraints {
            $0.top.equalTo(button4.snp.bottom).inset(-10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335)
            $0.height.equalTo(52)
        }
    }
}
