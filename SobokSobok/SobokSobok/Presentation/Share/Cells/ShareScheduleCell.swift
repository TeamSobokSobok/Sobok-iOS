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
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Override Functions
    
    override func configureLayout() {
        super.configureLayout()
        
        addSubview(stateView)
        stateView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18.adjustedWidth)
            $0.centerY.equalTo(topHStackView)
        }
    }
}


// MARK: - Public Functions

extension ShareScheduleCell {

    func configure(with state: (isLiked: Bool, isEat: Bool)) {
        stateView.isLiked = state.isLiked
        stateView.isEat = state.isEat
    }
}
