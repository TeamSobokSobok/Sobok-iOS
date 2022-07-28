//
//  ShareTopView.swift
//  SobokSobok
//
//  Created by taekki on 2022/07/27.
//

import UIKit

final class ShareTopView: BaseView {
    
    var friends: [String] = ["태현", "태현", "태현", "태현", "태현"]
    
    lazy var friendHStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .bottom
        $0.spacing = 22
    }
    
    lazy var addFriendButton = UIButton().then {
        $0.titleLabel?.font = .font(.pretendardExtraBold, ofSize: 17)
        $0.setImage(Image.icPlus48, for: .normal)
        $0.tintColor = Color.white
        $0.addTarget(self, action: #selector(addFriendButtonTapped), for: .touchUpInside)
    }
    
    override func setupView() {
        super.setupView()
        
        self.backgroundColor = Color.mint
        self.configureHStackView()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        addSubviews(friendHStackView, addFriendButton)
        friendHStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20.adjustedWidth)
            $0.bottom.equalToSuperview().inset(14.adjustedHeight)
        }
        
        addFriendButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(7.adjustedHeight)
            $0.centerY.equalTo(friendHStackView.snp.centerY)
        }
    }
}

extension ShareTopView {
    
    private func configureHStackView() {
        for friend in friends {
            let button = UIButton()
            button.setTitle(friend, for: .normal)
            button.setTitleColor(Color.white, for: .normal)
            button.addTarget(self, action: #selector(friendNameButtonTapped), for: .touchUpInside)
            friendHStackView.addArrangedSubviews(button)
        }
    }
    
    @objc func friendNameButtonTapped() {
        print("친구 이름")
    }
    
    @objc func addFriendButtonTapped() {
        print("친구 추가")
    }
}
