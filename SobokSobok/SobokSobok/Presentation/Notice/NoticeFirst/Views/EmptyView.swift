//
//  EmptyView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/02/17.
//

import UIKit

import SnapKit
import Then

final class EmptyView: UIView {

    // MARK: - Properties
    private var titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.text = "소중한 지안님의 알림"
        $0.textColor = Color.black
        $0.font = UIFont.font(.pretendardBold, ofSize: 24)
    }
    private var sobokImage = UIImageView().then {
        $0.image = Image.illustOops
        $0.contentMode = .scaleAspectFit
    }
    private var descriptionLabel = UILabel().then() {
        $0.textAlignment = .center
        $0.text = "아직 도착한 알림이 없어요!"
        $0.textColor = Color.gray500
        $0.font = UIFont.font(.pretendardRegular, ofSize: 16)
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        [titleLabel, sobokImage, descriptionLabel].forEach {
            addSubview($0)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(84)
            $0.left.equalTo(20)
        }
        
        sobokImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(297)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(165)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(491)
            $0.leading.equalToSuperview().offset(28)
            $0.width.equalTo(318)
        }

    }
}
