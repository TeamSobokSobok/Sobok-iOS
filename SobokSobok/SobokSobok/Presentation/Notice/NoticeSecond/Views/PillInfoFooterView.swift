//
//  PillInfoFooterView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/02/27.
//

import UIKit

import SnapKit
import Then

final class PillInfoFooterView: UICollectionReusableView {

    // MARK: - Properties
    private let noticeIcon = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Image.icNotice
    }
    private let noticeLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardMedium, ofSize: 14)
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
        $0.text = "전송받은 약이 내가 먹는 약과 다르다면\n수정해서 저장할 수 있어요"
        $0.textAlignment = .left
        $0.textColor = Color.gray500
    }
    private let noticeStack = UIStackView().then {
        $0.alignment = .center
        $0.axis = .horizontal
        $0.backgroundColor = Color.gray100
        $0.distribution = .fillProportionally
        $0.makeRounded(radius: 8)
        $0.spacing = 11
    }
    private let noticeView = UIView().then {
        $0.backgroundColor = Color.white
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    private func setUI() {
        noticeStack.addArrangedSubviews(noticeIcon, noticeLabel)
        noticeView.addSubview(noticeStack)
        self.addSubview(noticeView)
    }
    
    private func setConstraints() {
        noticeIcon.snp.makeConstraints {
            $0.width.equalTo(20)
            $0.height.equalTo(20)
            $0.leading.equalTo(noticeStack).inset(12)
        }
        noticeLabel.snp.makeConstraints {
            $0.width.equalTo(240)
            $0.height.equalTo(42)
        }
        noticeStack.snp.makeConstraints {
            $0.width.equalTo(335)
            $0.height.equalTo(66)
            $0.top.equalTo(noticeView)
            $0.leading.equalTo(noticeView)
            $0.bottom.equalTo(noticeView.snp.bottom).offset(-66)
        }
        noticeView.snp.makeConstraints {
            $0.height.equalTo(132)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
    }
}
