//
//  ShareTopView.swift
//  SobokSobok
//
//  Created by taekki on 2022/07/27.
//

import UIKit

final class ShareTopView: BaseView {
    
    var friends: [Member] = [] {
        didSet {
            updateUI()
            updateButton()
        }
    }
    
    var currentIndex: Int = 0 {
        didSet {
            updateButton()
        }
    }
    
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
        $0.isHidden = friends.isEmpty
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
            $0.bottom.equalToSuperview().inset(3.adjustedHeight)
        }
    }
}

extension ShareTopView {
    
    private func configureHStackView() {
        for index in 0..<5 {
            let button = UIButton()
            button.tag = index
            button.setTitleColor(Color.middleMint, for: .normal)
            button.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: 17)
            button.addTarget(self, action: #selector(friendNameButtonTapped), for: .touchUpInside)
            button.isHidden = true
            friendHStackView.addArrangedSubviews(button)
        }
    }
    
    private func updateUI() {
        for index in friends.indices {
            let button = friendHStackView.arrangedSubviews[index] as! UIButton
            button.isHidden = false
            button.setTitle(friends[index].memberName, for: .normal)
        }
        addFriendButton.isHidden = friends.isEmpty
    }
    
    private func updateButton() {
        for index in friends.indices {
            let button = friendHStackView.arrangedSubviews[index] as! UIButton
            
            if index == currentIndex {
                button.setTitleColor(Color.white, for: .normal)
                button.titleLabel?.font = UIFont.font(.pretendardExtraBold, ofSize: 17)
            } else {
                button.setTitleColor(Color.middleMint, for: .normal)
                button.titleLabel?.font = UIFont.font(.pretendardMedium, ofSize: 17)
            }
        }
    }
    
    @objc func friendNameButtonTapped(_ sender: UIButton) {
        currentIndex = sender.tag
    }
    
    @objc func addFriendButtonTapped() {
        print("친구 추가")
    }
}
