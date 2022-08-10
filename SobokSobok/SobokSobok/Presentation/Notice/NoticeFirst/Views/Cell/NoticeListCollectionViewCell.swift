//
//  NoticeListCollectionViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/06/23.
//

import UIKit

import SnapKit
import Then

enum SectionType: Int {
    case pill
    case calender
}
enum StatusType: Int {
    case waite
    case done
}

final class NoticeListCollectionViewCell: UICollectionViewCell {
    lazy var info: (() -> Void) = {}
    lazy var accept: (() -> Void) = {}
    lazy var refuse: (() -> Void) = {}
    
    var sectionType: SectionType = .pill {
        didSet {
            setNeedsLayout()
//            layoutIfNeeded()
        }
    }
    var statusType: StatusType = .waite {
        didSet {
            setNeedsLayout()
//            layoutIfNeeded()
        }
    }
    
    private lazy var iconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    let nameLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 18)
        $0.textColor = Color.gray900
        $0.textAlignment = .left
    }
    let infoButton = UIButton().then {
        $0.contentMode = .scaleAspectFit
    }
    let infoLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 14)
        $0.textColor = Color.gray900
        $0.textAlignment = .left
    }
    private lazy var infoImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Image.icMore16
    }
    private lazy var lineView = UIView().then {
        $0.backgroundColor = Color.gray150
    }
    let topStack = UIStackView().then {
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    let toolTipView = NoticeToolTipView(
        tipStartX: 184.0, tipWidth: 10.0, tipHeight: 6.2
    )
    let descriptionLabel = UILabel().then {
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 0
        $0.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        $0.textAlignment = .left
    }
    let timeLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 12)
        $0.textAlignment = .left
        $0.textColor = Color.gray500
    }
    private lazy var middleStack = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 4
    }
    let refuseButton = SobokButton.init(frame: CGRect(), mode: .lightMint, text: "거절", fontSize: 13)
    let acceptButton = SobokButton.init(frame: CGRect(), mode: .mainMint, text: "확인", fontSize: 13)
    let bottomStack = UIStackView().then {
        $0.alignment = .center
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 9
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI(section: .pill, status: .waite)
        setConstraints()
        
        presentDetailView()
        addAcceptAlert()
        addRefuseAlert()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    override func layoutSubviews() {
        switch sectionType {
        case .pill:
            iconImageView.image = Image.icPillAlarm
            toolTipView.isHidden = true
        case .calender:
            iconImageView.image = Image.icCalender
            infoButton.isHidden = true
            toolTipView.isHidden = true
        }
        
        switch statusType {
        case .waite:
            descriptionLabel.font = UIFont.font(.pretendardMedium, ofSize: 14)
            descriptionLabel.textColor = Color.gray700
        case .done:
            descriptionLabel.font = UIFont.font(.pretendardMedium, ofSize: 15)
            descriptionLabel.textColor = Color.gray600
            [topStack, bottomStack].forEach { $0.isHidden = true }
        }
    }
    
    func setUI(section: SectionType, status: StatusType) {
        sectionType = section
        statusType = status
        
        [topStack, toolTipView, middleStack, bottomStack].forEach { contentView.addSubview($0) }
        topStack.addArrangedSubviews(iconImageView, nameLabel, infoButton, lineView)
        infoButton.addSubviews(infoLabel, infoImage)
        middleStack.addArrangedSubviews(descriptionLabel, timeLabel)
        bottomStack.addArrangedSubviews(refuseButton, acceptButton)
        
        contentView.backgroundColor  = Color.white
        contentView.makeRounded(radius: 12)
    }
    
    private func setConstraints() {
        topStack.snp.makeConstraints { make in
            make.width.equalTo(299.adjustedWidth)
            make.height.equalTo(60.adjustedHeight)
            make.leading.equalToSuperview().offset(18)
            make.bottom.equalToSuperview().offset(92)
        }
        toolTipView.snp.makeConstraints { make in
            make.width.equalTo(247.adjustedWidth)
            make.height.equalTo(46.adjustedHeight)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(92)
        }
        iconImageView.snp.makeConstraints { make in
            make.width.equalTo(22.adjustedWidth)
            make.top.leading.equalToSuperview()
        }
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(156.adjustedWidth)
            make.height.equalTo(25.adjustedHeight)
            make.top.equalToSuperview()
            make.leading.equalTo(iconImageView).inset(10)
        }
        infoButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(nameLabel).inset(39)
        }
        infoImage.snp.makeConstraints { make in
            make.width.equalTo(16.adjustedWidth)
            make.height.equalTo(16.adjustedHeight)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel).inset(17)
            make.leading.bottom.trailing.equalToSuperview()
        }
        middleStack.snp.makeConstraints { make in
            make.top.equalTo(topStack.snp.bottom)
            make.leading.equalToSuperview().offset(18)
        }
        refuseButton.snp.makeConstraints {
            $0.width.equalTo(145.adjustedWidth)
            $0.height.equalTo(40.adjustedHeight)
        }
        acceptButton.snp.makeConstraints {
            $0.width.height.equalTo(refuseButton)
        }
        bottomStack.snp.makeConstraints {
            $0.height.equalTo(40.adjustedHeight)
            $0.top.equalTo(middleStack.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().inset(18)
        }
    }
}
