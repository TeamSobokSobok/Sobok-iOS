//
//  FriendNameView.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/20.
//

import UIKit

final class FriendNameView: BaseView {
    
    var completion: (() -> ())?
    
    lazy var friendNameLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardBold, ofSize: 24)
    }
    
    lazy var friendNameEditButton = UIButton().then {
        $0.setImage(Image.icPencil32, for: .normal)
        $0.tintColor = Color.gray400
        $0.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    override func setupView() {
        addSubviews(friendNameLabel, friendNameEditButton)
    }
    
    override func setupConstraints() {
        friendNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.adjustedHeight)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(35.adjustedHeight)
        }
        
        friendNameEditButton.snp.makeConstraints {
            $0.leading.equalTo(friendNameLabel.snp.trailing)
            $0.bottom.equalTo(friendNameLabel.snp.bottom)
        }
    }
}

extension FriendNameView {
    @objc func editButtonTapped(_ sender: UIButton) {
        print("click")
        completion?()
    }
}
