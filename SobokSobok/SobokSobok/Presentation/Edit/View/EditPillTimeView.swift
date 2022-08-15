//
//  EditPillTimeView.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/12.
//

import UIKit

import SnapKit
import Then

class EditPillTimeView: BaseView {
    
    lazy var timeLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 15)
        $0.textColor = Color.gray800
        $0.text = "약 먹는 시간"
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.register(PillTimeCollectionViewCell.self)
        $0.register(AddPillFirstFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddPillFirstFooterView.reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 54)
        layout.scrollDirection = .vertical
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false
        $0.collectionViewLayout = layout
    }
    
    override func setupView() {
        [timeLabel, collectionView].forEach {
            addSubview($0)
        }
    }
    
    override func setupConstraints() {
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}
