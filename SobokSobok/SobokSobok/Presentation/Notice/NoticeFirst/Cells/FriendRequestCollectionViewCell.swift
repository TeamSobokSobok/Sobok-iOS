//
//  FriendRequestCollectionViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/06/23.

import UIKit

import SnapKit
import Then

final class FriendRequestCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    lazy var accept: (() -> ()) = {}
    lazy var refuse: (() -> ()) = {}
    
    private lazy var pillIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Image.icPillAlarm
    }
    private lazy var pillName = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 18)
        $0.textColor = Color.gray900
        $0.textAlignment = .left
    }
    private lazy var lineView = UIView().then {
        $0.backgroundColor = Color.gray150
    }
    let topStack = UIStackView().then {
        $0.alignment = .fill
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    private lazy var descriptionLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 14)
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 0
        $0.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        $0.textColor = Color.gray700
        $0.textAlignment = .left
    }
    private lazy var timeLabel = UILabel().then {
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
    private lazy var refuseButton = SobokButton.init(frame: CGRect(), mode: .lightMint, text: "거절", fontSize: 13)
    private lazy var acceptButton = SobokButton.init(frame: CGRect(), mode: .mainMint, text: "확인", fontSize: 13)
    private lazy var bottomStack = UIStackView().then {
        $0.alignment = .center
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 9
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraints()
        
        addAcceptAlert()
        addRefuseAlert()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    private func setUI() {
        [topStack, middleStack, bottomStack].forEach { contentView.addSubview($0) }
        topStack.addArrangedSubviews(pillIcon, pillName, lineView)
        middleStack.addArrangedSubviews(descriptionLabel, timeLabel)
        bottomStack.addArrangedSubviews(refuseButton, acceptButton)
        self.backgroundColor = Color.white
        self.makeRounded(radius: 12)
    }
    
    private func setConstraints() {
        topStack.snp.makeConstraints { make in
            make.width.equalTo(299.adjustedWidth)
            make.height.equalTo(33.5.adjustedHeight)
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(18)
        }
        pillIcon.snp.makeConstraints { make in
            make.width.equalTo(22.adjustedWidth)
            make.top.leading.equalToSuperview()
        }
        pillName.snp.makeConstraints { make in
            make.width.equalTo(156.adjustedWidth)
            make.height.equalTo(25.adjustedHeight)
            make.top.equalToSuperview()
            make.leading.equalTo(pillIcon).inset(10)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(pillName).inset(17)
            make.leading.bottom.trailing.equalToSuperview()
        }
        middleStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview()
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
    
    private func addAcceptAlert() {
        acceptButton.addTarget(self, action: #selector(acceptButtonClicked), for: .touchUpInside)
    }
    
    private func addRefuseAlert() {
        refuseButton.addTarget(self, action: #selector(refuseButtonClicked), for: .touchUpInside)
    }
        
    @objc func acceptButtonClicked() { accept() }
    
    @objc func refuseButtonClicked() { refuse() }
    
    func setData(noticeListData: NoticeListData) {
        noticeIcon.image = noticeListData.makeNoticeImage()
        noticeTitle.text = noticeListData.noticeTitle
        noticeTime.text = noticeListData.noticeTime
    }
}
