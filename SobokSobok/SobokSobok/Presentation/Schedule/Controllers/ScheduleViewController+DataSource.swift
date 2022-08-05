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
        collectionView.backgroundView = pillLists.isEmpty ? emptyView : nil
        return pillLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pillLists[section].scheduleList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pill = pillLists[indexPath.section].scheduleList?[indexPath.row] else { return UICollectionViewCell() }
        
        if type == .home {
            let mainCell = collectionView.dequeueReusableCell(for: indexPath, cellType: MainScheduleCell.self)
            mainCell.delegate = self
            mainCell.isChecked = pill.isCheck
            mainCell.configure(with: pill)
            return mainCell
        }
        else {
            let shareCell = collectionView.dequeueReusableCell(for: indexPath, cellType: ShareScheduleCell.self)
            shareCell.configure(with: pill)
            return shareCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: ScheduleHeaderView.reuseIdentifier,
            for: indexPath
        ) as? ScheduleHeaderView else { return UICollectionReusableView() }

        headerView.showEditButton(isHidden: indexPath.section == 0 ? false : true)
        headerView.configure(withTime: pillLists[indexPath.section].scheduleTime)
        
        return headerView
    }
}

extension ScheduleViewController: MainScheduleCellDelegate {
    func checkButtonTapped(_ cell: MainScheduleCell) {
        guard let scheduleId = cell.pill?.scheduleId else { return }
        
        if cell.isChecked {
            showAlert(title: "복약하지 않은 약인가요?", message: "복약을 취소하면 소중한 사람들의 응원도 같이 삭제되어요", completionTitle: "복약 취소", cancelTitle: "취소") { _ in
                cell.isChecked.toggle()
                self.uncheckPillSchedule(scheduleId: scheduleId)
            }

        } else {
            checkPillSchedule(scheduleId: scheduleId)
            cell.isChecked.toggle()
        }
    }
}
