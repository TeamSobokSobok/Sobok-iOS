//
//  ShareScheduleCell.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/05.
//

import UIKit

final class ShareScheduleCell: ScheduleCell {

    // MARK: - UI Components
    
    lazy var stateView = StateView()
    
    
    // MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupConstraints()
    }
}


// MARK: - Private Functions

extension ShareScheduleCell {

    private func setupConstraints() {
        addSubview(stateView)
        stateView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18.adjustedWidth)
            $0.centerY.equalTo(topHStackView)
        }
    }
}
