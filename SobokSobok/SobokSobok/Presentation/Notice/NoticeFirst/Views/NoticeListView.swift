//
//  NoticeListView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/02/17.
//

import UIKit

import SnapKit
import Then

final class NoticeListView: BaseView {
    // MARK: - Properties
    private let titleLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardBold, ofSize: 24)
        $0.textAlignment = .left
        $0.text = "소중한 지안님의 알림"
        $0.textColor = Color.black
    }
    let noticeListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width - 40, height: 167)
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
        layout.scrollDirection = .vertical
        $0.backgroundColor = .clear
        $0.collectionViewLayout = layout
      $0.register(NoticeListCollectionViewCell.self)
        $0.showsVerticalScrollIndicator = false
    }
    
    // MARK: - Functions
    override func setupView() {
        [titleLabel, noticeListCollectionView].forEach { addSubview($0) }
        self.backgroundColor = Color.gray150
    }
    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(84)
            $0.leading.equalToSuperview().offset(20)
        }
        noticeListCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(141)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
