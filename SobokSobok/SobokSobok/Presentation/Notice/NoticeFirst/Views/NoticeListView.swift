//
//  NoticeListView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/02/17.
//

import UIKit

import SnapKit
import Then

final class NoticeListView: UIView {

    // MARK: - Properties
    private var titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.text = "소중한 지안님의 알림"
        $0.textColor = Color.black
        $0.font = UIFont.font(.pretendardBold, ofSize: 24)
    }
    
    let noticeListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 40, height: 167)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        $0.collectionViewLayout = layout
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.register(NoticeListCollectionViewCell.self)
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        [titleLabel, noticeListCollectionView].forEach {
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
            $0.leading.equalToSuperview().offset(20)
        }

        noticeListCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(141)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-32)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }

}
