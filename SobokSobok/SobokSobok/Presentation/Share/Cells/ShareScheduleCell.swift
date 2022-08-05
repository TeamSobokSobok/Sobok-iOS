//
//  ShareScheduleCell.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/05.
//

import UIKit

final class ShareScheduleCell: ScheduleCell {

    lazy var shareStateView = ShareStateView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupConstraints()
    }
}

extension ShareScheduleCell {

    private func setupConstraints() {
        addSubview(shareStateView)
        shareStateView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(18.adjustedWidth)
            $0.centerY.equalTo(topHStackView)
        }
    }
}
