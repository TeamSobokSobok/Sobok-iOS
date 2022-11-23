//
//  NoticeListCollectionViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/06/23.
//

import UIKit

import SnapKit
import Then

final class NoticeListCollectionViewCell: UICollectionViewCell, NoticeListPresentable {
    // MARK: - Properties
    lazy var info: (() -> Void) = {}
    lazy var accept: (() -> Void) = {}
    lazy var refuse: (() -> Void) = {}
    
    var sectionType: SectionType = .pill {
        didSet {
            layoutIfNeeded()
        }
    }
    var statusType: StatusType = .waite {
        didSet {
            layoutIfNeeded()
        }
    }
    
    // MARK: - UI Components
    lazy var containerStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
    }
    private lazy var topStackView =  UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 10
    }
    private lazy var iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    let nameLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 18)
        $0.textAlignment = .left
        $0.textColor = Color.gray900
    }
    let detailButton = UIButton().then {
        $0.contentMode = .scaleAspectFit
        $0.setImage(Image.icDetail16, for: .normal)
    }
    let toolTipView = SobokToolTipView(
        tipContent: "친구가 보낸 약 알림 일정을 확인해보세요",
        tipStartX: 184, tipWidth: 10, tipHeight: 6.2,
        duration: 1.0).then {
        $0.isHidden = true
    }
    private lazy var middleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
    }
    private lazy var lineView = UIView().then {
        $0.backgroundColor = Color.gray150
    }
    let descriptionLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 14)
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 2
        $0.textAlignment = .left
        $0.textColor = Color.gray600
    }
    let timeLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 12)
        $0.textAlignment = .left
        $0.textColor = Color.gray500
    }
    private lazy var bottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 7
    }
    let refuseButton = SobokButton(frame: .zero, mode: .lightMint, text: "거절", fontSize: 13)
    let acceptButton = SobokButton(frame: .zero, mode: .mainMint, text: "수락", fontSize: 13)
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView(section: .pill, status: .waite)
        setupConstraint()
        
        presentDetailView()
        addAcceptAlert()
        addRefuseAlert()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    func setupView(section: SectionType, status: StatusType) {
        sectionType = section
        statusType = status
        divideSection()
        
        topStackView.addArrangedSubviews(iconImageView, nameLabel, detailButton)
//        topStackView.bringSubviewToFront(toolTipView)
        middleStackView.addArrangedSubviews(descriptionLabel, timeLabel)
        bottomStackView.addArrangedSubviews(refuseButton, acceptButton)
        containerStackView.addArrangedSubviews(topStackView, middleStackView, bottomStackView)
        
        contentView.addSubviews(lineView, containerStackView)
        contentView.backgroundColor = Color.white
        contentView.makeRounded(radius: 12)

    }
    
    func setupConstraint() {
        containerStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(18)
        }

        // MARK: - top
        topStackView.snp.makeConstraints { make in
            make.height.equalTo(25.adjustedHeight)
        }
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(22)
            make.top.equalTo(topStackView.snp.top).offset(1.5)
            make.leading.equalTo(topStackView.snp.leading)
        }
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(156.adjustedWidth)
            make.top.equalTo(topStackView.snp.top)
            make.leading.equalTo(topStackView.snp.leading).inset(30)
        }
        detailButton.snp.makeConstraints { make in
            make.width.equalTo(72.adjustedWidth)
            make.top.equalTo(topStackView.snp.top)
            make.leading.equalTo(topStackView.snp.leading).inset(217)
        }
        toolTipView.snp.makeConstraints { make in
            make.width.equalTo(247.adjustedWidth)
            make.height.equalTo(36.adjustedHeight)
            make.top.equalTo(detailButton.snp.bottom).offset(1)
        }

        // MARK: - middle
        lineView.snp.makeConstraints { make in
            make.height.equalTo(2.adjustedHeight)
            make.top.equalTo(topStackView.snp.bottom).offset(18)
            make.leading.trailing.equalTo(middleStackView)
        }
        middleStackView.snp.makeConstraints { make in
            make.height.equalTo(50.adjustedHeight)
            make.top.equalTo(lineView.snp.bottom).offset(8)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.height.equalTo(21.adjustedHeight)
            make.top.equalTo(middleStackView.snp.top)
        }
        timeLabel.snp.makeConstraints { make in
            make.height.equalTo(17)
            make.top.equalTo(middleStackView.snp.top).offset(25)
        }
        
        bottomStackView.snp.makeConstraints {
            $0.height.equalTo(52.adjustedHeight)
        }
        refuseButton.snp.makeConstraints { make in
            make.width.equalTo(146.adjustedWidth)
            make.height.equalTo(40.adjustedHeight)
            make.top.equalTo(bottomStackView.snp.top).offset(12)
        }
    }
    
    func divideSection() {
        switch sectionType {
        case .pill:
            iconImageView.image = Image.icPillAlarm
            detailButton.isHidden = false
        case .calender:
            iconImageView.image = Image.icShareAlarm
            detailButton.isHidden = true
        }
        switch statusType {
        case .waite:
            descriptionLabel.textColor = Color.gray700
            [topStackView, lineView, bottomStackView].forEach { $0.isHidden = false }
        case .done:
            descriptionLabel.textColor = Color.gray600
            [topStackView, lineView, bottomStackView].forEach { $0.isHidden = true }
        }
    }
}
