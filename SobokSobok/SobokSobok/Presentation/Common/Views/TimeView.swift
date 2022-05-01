//
//  TimeView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/04/30.
//

import UIKit

import SnapKit
import Then

final class TimeView: BaseView {

    // MARK: - Properties
    let timeLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 18)
        $0.textColor = Color.gray800
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    override func setupView() {
        super.setupView()

        backgroundColor = Color.white
        makeRoundedWithBorder(radius: 6, color: Color.darkMint.cgColor)
        
        addSubview(timeLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
}
