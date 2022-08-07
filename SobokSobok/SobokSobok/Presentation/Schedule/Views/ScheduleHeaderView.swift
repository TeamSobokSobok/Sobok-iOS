//
//  ScheduleHeaderView.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/21.
//

import UIKit

final class ScheduleHeaderView: UICollectionReusableView {
    
    // MARK: - Properties
    
    var isEdit = false {
        didSet {
            updateUI()
        }
    }
    
    
    // MARK: - UI Components
    
    private lazy var timeLabel = UILabel()
    private lazy var editButton = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(Color.gray700, for: .normal)
        $0.titleLabel?.setTypoStyle(typoStyle: .body5)
        $0.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}


// MARK: - Private Functions

extension ScheduleHeaderView {
    
    private func configureLayout() {
        addSubviews(timeLabel, editButton)
        
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
    
    private func updateUI() {
        editButton.setTitle(isEdit ? "완료" : "수정", for: .normal)
    }
}


// MARK: - Public Functions

extension ScheduleHeaderView {

    func configure(withTime time: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormatType.second.description
        let date = dateFormatter.date(from: time)
        let time = date?.toString(of: .time)
        timeLabel.text = time
        timeLabel.setTypoStyle(typoStyle: .title1)
    }
    
    func showEditButton(isHidden: Bool) {
        editButton.isHidden = isHidden
    }
}


// MARK: - Objc Functions

extension ScheduleHeaderView {
    
    @objc func editButtonTapped(_ sender: UIButton) {
        isEdit.toggle()
        NotificationCenter.default.post(name: Notification.Name("edit"), object: self)
    }
}
