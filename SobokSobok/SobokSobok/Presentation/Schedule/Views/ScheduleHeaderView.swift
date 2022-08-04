//
//  ScheduleHeaderView.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/21.
//

import UIKit

final class ScheduleHeaderView: UICollectionReusableView {
    private lazy var timeLabel = UILabel()
    private lazy var editButton = UIButton().then {
        $0.isHidden = true
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(Color.gray700, for: .normal)
        $0.titleLabel?.setTypoStyle(typoStyle: .body5)
        $0.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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

    func showEditButton(isHidden: Bool) {
        editButton.isHidden = isHidden
    }
    
    func configure(withTime time: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.FormatType.second.description
        let date = dateFormatter.date(from: time)
        let time = date?.toString(of: .time)
        timeLabel.text = time
        timeLabel.setTypoStyle(typoStyle: .title1)
    }
    
    @objc func editButtonTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("edit"), object: self)
    }
}
