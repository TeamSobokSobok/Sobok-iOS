//
//  ButtonStyle.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/02/19.
//

import UIKit

import SnapKit

enum ButtonMode: Int, CaseIterable {
    case lightMint
    case mainMint
    case inactive
    case active
}

final class SobokButton: UIButton {
    
    private var mode: ButtonMode
    private var text: String
    
    init(frame: CGRect, mode: ButtonMode, text: String, fontSize: CGFloat) {
        self.mode = mode
        self.text = text
        super.init(frame: frame)
        setUI(text: text, fontSize: Int(fontSize))
        setupMode(mode: mode)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUI(text: String, fontSize: Int) {
        makeRounded(radius: 8)
        setTitle(text, for: .normal)
        titleLabel?.font = UIFont.font(.pretendardSemibold, ofSize: CGFloat(fontSize))
    }
    
    private func setupMode(mode: ButtonMode) {
        self.mode = mode
        switch self.mode {
        case .lightMint:
            backgroundColor = Color.lightMint
            setTitleColor(Color.darkMint, for: .normal)
        case .mainMint:
            backgroundColor = Color.mint
            setTitleColor(Color.white, for: .normal)
        case .inactive:
            backgroundColor = Color.gray100
            setTitleColor(Color.gray500, for: .normal)
        case .active:
            backgroundColor = Color.lightMint
            setTitleColor(Color.darkMint, for: .normal)
            makeRoundedWithBorder(radius: 8, color: Color.darkMint.cgColor)
        }
    }
}
