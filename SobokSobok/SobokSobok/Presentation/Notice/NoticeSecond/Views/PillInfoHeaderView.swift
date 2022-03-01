//
//  PillInfoHeaderView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/03/01.
//

import UIKit

import SnapKit
import Then

class PillInfoHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    private let senderLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.text = "효영님이 전송해준 약이에요"
        $0.textAlignment = .left
        $0.textColor = Color.gray700
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    private func setUI() {
        self.addSubview(senderLabel)
    }
    
    private func setConstraints() {
        senderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
}
