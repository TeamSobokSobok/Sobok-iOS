//
//  SpecificButton.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/04.
//

import UIKit.UIButton
import Foundation

final class SpecificButton: UIButton {
    
    private var specific: Specific?
    
    override var isSelected: Bool {
        didSet {
            isSelected ? selectConfiguration() : unselectConfiguration()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(specific: Specific) {
        self.init()
        self.specific = specific
        self.setConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("DefaultFillButton: fatal Error Message")
    }
    
    private func setConfiguration() {
        layer.masksToBounds = true
        switch specific {
        case .everyday:
            setButtonText(text: "매일")
        case .day:
            setButtonText(text: "특정 요일")
        case .period:
            setButtonText(text: "특정 간격")
        case .none:
            break
        }
    }
    
    private func setButtonText(text: String) {
        makeRounded(radius: 8)
        setTitle(text, for: .normal)
        titleLabel?.font = UIFont.font(.pretendardSemibold, ofSize: 16)
    }
    
    private func unselectConfiguration() {
        backgroundColor = Color.gray100
        setTitleColor(Color.gray500, for: .normal)
        makeRoundedWithBorder(radius: 8, color: Color.gray100.cgColor)
    }
    
    private func selectConfiguration() {
        backgroundColor = Color.lightMint
        setTitleColor(Color.darkMint, for: .normal)
        makeRoundedWithBorder(radius: 8, color: Color.darkMint.cgColor)
    }
}
