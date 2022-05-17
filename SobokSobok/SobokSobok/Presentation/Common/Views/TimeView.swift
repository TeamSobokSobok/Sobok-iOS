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
    convenience init(time: String) {
        self.init(frame: .zero)
        
        self.timeLabel.text = time
        updateUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Functions
    override func setupView() {
        backgroundColor = Color.white
        makeRoundedWithBorder(radius: 6, color: Color.darkMint.cgColor)
        
        addSubview(timeLabel)
    }
    
    override func setupConstraints() {
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
        }
    }
    
    private func updateUI() {
        let viewSize = timeLabel.intrinsicContentSize
        let width = viewSize.width + 10
        let height = viewSize.height + 6
        
        frame.size = CGSize(width: width, height: height)
        timeLabel.center = CGPoint(x: width / 2, y: height / 2)
    }
}
