//
//  AddPillFirstFooterView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/09.
//

import Foundation

import UIKit

final class AddPillFirstFooterView: UICollectionReusableView {
    
    let viewModel = AddTimeViewModel()
    
    lazy var addTimeLabel = UILabel().then {
        $0.text = "시간 추가"
        $0.textColor = Color.gray600
        $0.font = UIFont.font(.pretendardRegular, ofSize: 16)
    }
    
    lazy var addTimeButton = UIButton().then {
        $0.makeRoundedWithBorder(radius: 10, color: Color.gray150.cgColor, borderWith: 1)
        $0.backgroundColor = Color.gray100
        $0.addTarget(self, action: #selector(addPillCellButtonClicked), for: .touchUpInside)
    }
    
    lazy var plusImageView = UIImageView().then {
        $0.image = Image.icPlus48
        $0.tintColor = Color.gray600
    }
    
    let horizontalStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.alignment = .center
        $0.spacing = 10
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(horizontalStackView)
        
        horizontalStackView.addSubview(addTimeButton)
        
        [plusImageView, addTimeLabel].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addTimeButton.snp.makeConstraints {
            $0.top.equalTo(11)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
            $0.height.equalTo(54)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(addTimeButton)
            $0.width.equalTo(UIScreen.main.bounds.width - 40)
        }
        
        addTimeLabel.snp.makeConstraints {
            $0.top.equalTo(horizontalStackView.snp.top)
        }
        
        plusImageView.snp.makeConstraints {
            $0.width.height.equalTo(26)
        }
    }
    
    @objc func addPillCellButtonClicked() {
        viewModel.addCellClosure?()
    }
}
