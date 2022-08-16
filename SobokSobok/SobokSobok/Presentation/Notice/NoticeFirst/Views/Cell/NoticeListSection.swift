//
//  NoticeListSection.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/07/27.
//

import UIKit

extension NoticeViewController {
    func createSection() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(180.adjustedHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(180.adjustedHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 18, leading: 0, bottom: 0, trailing: 0)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .none
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
