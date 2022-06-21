//
//  ScheduleViewController+CollectionView.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/21.
//

import UIKit

// MARK: - CollectionView Setup

extension ScheduleViewController {
    func registerCell() {
        collectionView.register(
            PillScheduleCell.self,
            forCellWithReuseIdentifier: PillScheduleCell.reuseIdentifier
        )
        
        collectionView.register(
            ScheduleHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ScheduleHeaderView.reuseIdentifier
        )
    }
    
    func setCollectionView() {
        collectionView.dataSource = self
        collectionView.backgroundColor = Color.gray150
        collectionView.collectionViewLayout = generateLayout()
    }
}

extension ScheduleViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PillScheduleCell.reuseIdentifier, for: indexPath) as? PillScheduleCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: ScheduleHeaderView.reuseIdentifier,
                for: indexPath
            ) as? ScheduleHeaderView else { return UICollectionReusableView() }
            if indexPath.section != 0 { headerView.hideEditButton() }
            return headerView
        default:
            assert(false, "헤더 뷰 찾을 수 없음")
        }
    }
}

extension ScheduleViewController {
    func generateLayout() -> UICollectionViewLayout {
        // 1
        let itemSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(140))
        
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 2
        let groupSize = NSCollectionLayoutSize(
          widthDimension: .fractionalWidth(1.0),
          heightDimension: .estimated(140))
        let group = NSCollectionLayoutGroup.horizontal(
          layoutSize: groupSize,
          subitem: fullPhotoItem,
          count: 1)
        
        // 3
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [createHeader()]
        section.interGroupSpacing = 10
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func createHeader()
    -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(77)
        )
        let headerElement = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return headerElement
    }
}
