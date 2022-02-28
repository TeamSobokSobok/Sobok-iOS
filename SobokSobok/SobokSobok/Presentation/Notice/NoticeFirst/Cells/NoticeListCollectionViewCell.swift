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
    
    private let noticeIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    private let noticeTitle = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 0
        $0.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        $0.textColor = Color.gray900
        $0.textAlignment = .left
    }
    private let noticeTime = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 12)
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 0
        $0.setContentCompressionResistancePriority(UILayoutPriority.required, for: .vertical)
        $0.textAlignment = .left
        $0.textColor = Color.gray500
    }
    private let labelStack = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fill
        $0.spacing = 4
    }
    private let refuseButton = SobokButton.init(frame: CGRect(), mode: .lightMint, text: "거절", fontSize: 13)
    private let acceptButton = SobokButton.init(frame: CGRect(), mode: .mainMint, text: "확인", fontSize: 13)
    private let buttonStack = UIStackView().then {
        $0.alignment = .center
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 9
    }
    private let contentStack = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 16
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addAcceptAlert()
        addRefuseAlert()
        setUI()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    private func setUI() {
        labelStack.addArrangedSubviews(noticeTitle, noticeTime)
        buttonStack.addArrangedSubviews(refuseButton, acceptButton)
        contentStack.addArrangedSubviews(noticeIcon, labelStack, buttonStack)
        [noticeIcon, labelStack, buttonStack].forEach {
            contentView.addSubview($0)
        }
        self.backgroundColor = Color.white
        self.makeRounded(radius: 12)
    }
    
    private func setConstraints() {
        noticeIcon.snp.makeConstraints {
            $0.width.equalTo(33.5)
            $0.height.equalTo(33.5)
            $0.top.equalToSuperview().offset(26.25)
            $0.leading.equalToSuperview().offset(18.25)
        }
        noticeTitle.snp.makeConstraints {
            $0.width.equalTo(257)
        }
        noticeTime.snp.makeConstraints {
            $0.height.equalTo(17)
        }
        labelStack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(23)
            $0.leading.equalToSuperview().offset(60)
            $0.trailing.equalToSuperview().inset(24)
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
            $0.height.equalTo(40)
            $0.top.equalTo(labelStack.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(18)
            $0.bottom.equalToSuperview().offset(-25)
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
