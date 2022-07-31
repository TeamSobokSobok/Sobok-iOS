//
//  ScheduleViewController+DataSource.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/22.
//

import UIKit

// MARK: - UICollectionViewDataSource

extension ScheduleViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return pillLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pillLists[section].scheduleList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MainScheduleCell.reuseIdentifier,
            for: indexPath
        ) as? MainScheduleCell else { return UICollectionViewCell() }
        
        cell.delegate = self
        
        if let pill = pillLists[indexPath.section].scheduleList?[indexPath.row] {
            cell.configureCell(with: pill)
            cell.isChecked = pill.isCheck
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: ScheduleHeaderView.reuseIdentifier,
            for: indexPath
        ) as? ScheduleHeaderView else { return UICollectionReusableView() }
        
        if indexPath.section != 0 { headerView.hideEditButton() }
        
        return headerView
    }
}

extension ScheduleViewController: MainScheduleCellDelegate {
    func checkButtonTapped(_ cell: MainScheduleCell) {
        guard let scheduleId = cell.pill?.scheduleId else { return }
        
        if cell.isChecked {
            uncheckPillSchedule(scheduleId: scheduleId)
        } else {
            checkPillSchedule(scheduleId: scheduleId)
        }
        
        cell.isChecked.toggle()
    }
}
