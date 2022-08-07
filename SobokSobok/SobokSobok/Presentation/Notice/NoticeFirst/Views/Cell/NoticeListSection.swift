//
//  NoticeListSection.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/07/27.
//

import UIKit

extension NoticeListCollectionViewCell {
    func createPillSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(180.adjustedHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(180.adjustedHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    func createFriendSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(180.adjustedHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(180.adjustedHeight))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = .none
        return section
    }
    
    func presentDetailView() {
        infoButton.addTarget(self, action: #selector(detailButtonClicked), for: .touchUpInside)
    }
    
    func addAcceptAlert() {
        acceptButton.addTarget(self, action: #selector(acceptButtonClicked), for: .touchUpInside)
    }
    
    func addRefuseAlert() {
        refuseButton.addTarget(self, action: #selector(refuseButtonClicked), for: .touchUpInside)
    }
    
    @objc func detailButtonClicked() { info() }
    @objc func acceptButtonClicked() { accept() }
    @objc func refuseButtonClicked() { refuse() }
}
