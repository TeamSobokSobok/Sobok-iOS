//
//  ShareEmptyView.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/25.
//

import UIKit

final class ShareEmptyView: BaseView {
    
    let emptyImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = Image.new
    }
    
    lazy var addButton = UIButton().then {
        $0.backgroundColor = Color.mint
        $0.setTitle("추가하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 12
        $0.titleLabel?.font = UIFont.font(.pretendardSemibold, ofSize: 18)
    }
    
    override func setupView() {
        addSubviews(emptyImageView, addButton)
        
        backgroundColor = Color.gray150
    }
    
    override func setupConstraints() {
        emptyImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(122.adjustedHeight)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335.adjustedWidth)
            $0.height.equalTo(278.adjustedHeight)
        }
        
        addButton.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(122.adjustedHeight)
            $0.leading.trailing.equalToSuperview().inset(20.adjustedWidth)
            $0.height.equalTo(52.adjustedHeight)
        }
    }
}
