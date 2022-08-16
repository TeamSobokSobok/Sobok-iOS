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
            setNeedsLayout()
        }
    }
    var statusType: StatusType = .waite {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: - UI Components
    private lazy var topStackView =  UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.spacing = 0
    }
    private lazy var iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    let nameLabel = UILabel().then {
        $0.font = UIFont.font(FontType.pretendardSemibold, ofSize: 18)
        $0.textAlignment = .left
        $0.textColor = Color.gray900
    }
    let detailButton = UIButton()
    let detailLabel = UILabel().then {
        $0.font = UIFont.font(FontType.pretendardMedium, ofSize: 14)
        $0.text = "상세보기"
        $0.textColor = Color.gray900
    }
    private lazy var detailImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Image.icMore16
    }
    let toolTipView = NoticeToolTipView(tipStartX: 184, tipWidth: 10, tipHeight: 6.2)
    private lazy var middleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
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
        
        topStackView.addArrangedSubviews(iconImageView, nameLabel, detailButton, detailLabel, detailImageView)
        [detailLabel, detailImageView].forEach { $0.bringSubviewToFront(detailButton) }
        topStackView.bringSubviewToFront(toolTipView)
        middleStackView.addArrangedSubviews(lineView, descriptionLabel, timeLabel)
        bottomStackView.addArrangedSubviews(refuseButton, acceptButton)
        
        contentView.addSubviews(topStackView, toolTipView, middleStackView, bottomStackView)
        contentView.backgroundColor = Color.white
        contentView.makeRounded(radius: 12)
    }
    
    func setupConstraint() {
        topStackView.snp.makeConstraints { make in
            make.width.equalTo(299.adjustedWidth)
            make.height.equalTo(42.adjustedHeight)
            make.top.leading.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(22.adjustedWidth)
            make.top.equalToSuperview().offset(1.5)
            make.leading.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(156.adjustedWidth)
            make.height.equalTo(25.adjustedHeight)
            make.top.equalToSuperview()
            make.leading.equalTo(iconImageView.snp.trailing).offset(10)
        }
        detailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.equalTo(nameLabel.snp.trailing).offset(39)
        }
        detailImageView.snp.makeConstraints { make in
            make.width.equalTo(16.adjustedWidth)
            make.top.equalToSuperview().offset(4.5)
            make.leading.equalTo(detailLabel.snp.trailing).offset(4)
        }
        detailButton.snp.makeConstraints { make in
            make.width.equalTo(72.adjustedWidth)
            make.height.equalTo(21.adjustedHeight)
            make.centerX.equalTo(detailLabel)
        }
        toolTipView.snp.makeConstraints { make in
            make.width.equalTo(247.adjustedWidth)
            make.height.equalTo(39.adjustedHeight)
            make.top.equalToSuperview().offset(42)
            make.trailing.equalToSuperview()
        }
        middleStackView.snp.makeConstraints { make in
            make.width.equalTo(299.adjustedWidth)
            make.height.equalTo(62.adjustedHeight)
            make.top.leading.equalTo(topStackView)
        }
        lineView.snp.makeConstraints { make in
            make.height.equalTo(2.adjustedHeight)
            make.top.leading.trailing.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        bottomStackView.snp.makeConstraints { make in
            make.top.equalTo(middleStackView).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
        }
        refuseButton.snp.makeConstraints { make in
            make.width.equalTo(146.adjustedWidth)
            make.height.equalTo(40.adjustedHeight)
        }
    }
    
    func divideSection() {
        switch sectionType {
        case .pill:
            iconImageView.image = Image.icPillAlarm
        case .calender:
            iconImageView.image = Image.icShareAlarm
            [detailLabel, detailImageView, detailButton].forEach { $0.isHidden = true }
            toolTipView.isHidden = true
        }
        
        switch statusType {
        case .waite:
            descriptionLabel.textColor = Color.gray700
        case .done:
            [topStackView, bottomStackView].forEach { $0.isHidden = true }
        }
    }
}
