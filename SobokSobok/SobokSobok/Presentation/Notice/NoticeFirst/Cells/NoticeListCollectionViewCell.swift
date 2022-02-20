//
//  NoticeListCollectionViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/02/17.
//

import UIKit

import SnapKit
import Then

final class NoticeListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    lazy var accept: (() -> ()) = {}
    lazy var refuse: (() -> ()) = {}
    
    private var noticeIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private var noticeTitle = UILabel().then {
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.lineBreakMode = .byCharWrapping
        $0.textColor = Color.gray900
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
    }
    private var noticeTime = UILabel().then {
        $0.textAlignment = .left
        $0.textColor = Color.gray500
        $0.font = UIFont.font(.pretendardMedium, ofSize: 12)
    }
    private var labelStack = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
    }
    private var refuseButton = UIButton().then {
        $0.makeRounded(radius: 8)
        $0.backgroundColor = Color.lightMint
        $0.setTitle("거절", for: .normal)
        $0.setTitleColor(Color.darkMint, for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardSemibold, ofSize: 13)
    }
    private var acceptButton = UIButton().then {
        $0.makeRounded(radius: 8)
        $0.backgroundColor = Color.mint
        $0.setTitle("수락", for: .normal)
        $0.setTitleColor(Color.white, for: .normal)
        $0.titleLabel?.font = UIFont.font(.pretendardSemibold, ofSize: 13)
    }
    private var buttonStack = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 9
        $0.alignment = .center
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addAcceptAlert()
        addRefuseAlert()
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    private func setUI() {
        [noticeIcon, labelStack, buttonStack].forEach {
            contentView.addSubview($0)
        }
        labelStack.addArrangedSubviews(noticeTitle, noticeTime)
        buttonStack.addArrangedSubviews(refuseButton, acceptButton)
    }
    
    private func setConstraints() {
        noticeIcon.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22.3)
            $0.leading.equalToSuperview().inset(17.3)
            $0.width.equalTo(33.5)
            $0.height.equalTo(33.5)
        }
        labelStack.snp.makeConstraints {
            $0.width.equalTo(257)
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalToSuperview().inset(60)
            $0.trailing.equalToSuperview().inset(18)
        }
        refuseButton.snp.makeConstraints {
            $0.width.equalTo(145)
            $0.height.equalTo(40)
        }
        acceptButton.snp.makeConstraints {
            $0.width.equalTo(145)
            $0.height.equalTo(40)
        }
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(labelStack.snp.bottom).inset(-16)
            $0.leading.equalToSuperview().inset(18)
        }
    }
    
    private func addAcceptAlert() {
        acceptButton.addTarget(self, action: #selector(acceptButtonClicked), for: .touchUpInside)
    }
    
    private func addRefuseAlert() {
        refuseButton.addTarget(self, action: #selector(refuseButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func acceptButtonClicked() {
        accept()
    }
    
    @objc
    func refuseButtonClicked() {
        refuse()
    }
    
    func setData(noticeListData: NoticeListData) {
        noticeIcon.image = noticeListData.makeNoticeImage()
        noticeTitle.text = noticeListData.noticeTitle
        noticeTime.text = noticeListData.noticeTime
    }
    
}
