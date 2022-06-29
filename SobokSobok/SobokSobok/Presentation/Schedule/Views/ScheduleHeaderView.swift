//
//  ScheduleHeaderView.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/21.
//

import UIKit

final class ScheduleHeaderView: UICollectionReusableView {
    private let timeLabel = UILabel().then {
        $0.text = "오후 1:00"
    }
    
    private lazy var editButton = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(Color.gray700, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureView()
        configureConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureView() {
        addSubviews(timeLabel, editButton)
    }
    
    private func configureConstraints() {
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(6)
        }
        editButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(23)
        }
    }
    
    private func configureUI() {
        timeLabel.setTypoStyle(typoStyle: .title1)
        editButton.titleLabel?.setTypoStyle(typoStyle: .body5)
    }
    
    func hideEditButton() {
        editButton.isHidden = true
    }
}
