//
//  CalendarViewController+CollectionViewDataSource.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/18.
//

import UIKit

// MARK: - CollectionView DataSource

extension CalendarViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if pillItems.count == 0 {
            emptyImageView.isHidden = false
            emptyViewHeight.constant = 300
            view.layoutIfNeeded()
            return 0
        } else {
            emptyImageView.isHidden = true
            emptyViewHeight.constant = 0
            view.layoutIfNeeded()
            return pillItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if pillItems.count == 0 {
            return 0
        } else {
            return pillItems[section].scheduleList?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            for: indexPath, cellType: MedicineCollectionViewCell.self
        )
        
        cell.pillCellType = tabType == .home ? .home : .share
        let pill = pillItems[indexPath.section].scheduleList?[indexPath.row]
        
        cell.contentView.backgroundColor = Color.white
        cell.contentView.makeRounded(radius: 12)
        cell.pillName.text = pill?.pillName
        
        cell.checkButton.isHidden = editMode ?? false || tabType == .share
        cell.editButton.isHidden = editMode ?? false
        
        cell.editClosure = {
            self.showActionSheet(pillId: pill?.pillId ?? 0, date: self.selectedDate)
            collectionView.reloadData()
        }

        let stickerCount = pill?.stickerId?.count ?? 0
        cell.stickerStackView.isHidden = stickerCount == 0
        cell.stickerCountLabel.isHidden = stickerCount == 0
        
        if stickerCount > 0 {
            if let stickerId = pill?.stickerId {
                cell.setSticker(stickerId: stickerId)
            }
        }
        
        let stickerTotalCount = pill?.stickerTotalCount ?? 0
        cell.stickerCountLabel.text = stickerTotalCount > 4 ? "+ \(stickerTotalCount - stickerCount)" : ""
   
        cell.stickerClosure = { [weak self] in
            guard let self = self else { return }
            self.checkSticker(scheduleId: pill?.scheduleId ?? 0)
        }
        
        cell.checkClosrue = {
            guard let scheduleId = pill?.scheduleId else { return }
            if cell.isChecked {
                self.checkPillDetail(scheduleId: scheduleId)
            } else {
                self.uncheckPillDetail(scheduleId: scheduleId)
            }
        }
        
        cell.emotionClosure = {
            let stickerPopUpView = SendStickerPopUpViewController.instanceFromNib()
            stickerPopUpView.modalPresentationStyle = .overCurrentContext
            stickerPopUpView.modalTransitionStyle = .crossDissolve
            stickerPopUpView.scheduleId = pill?.scheduleId ?? 0
            stickerPopUpView.delegate = self
            self.present(stickerPopUpView, animated: false, completion: nil)
        }
        
        cell.isLikedState = pill?.isLikedSchedule ?? false
        cell.eatState = pill?.isCheck ?? false
        cell.isChecked = pill?.isCheck ?? false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TimeHeaderView.reuseIdentifier,
                for: indexPath
            ) as? TimeHeaderView else { return UICollectionReusableView() }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Date.FormatType.second.description
            let date = dateFormatter.date(from: pillItems[indexPath.section].scheduleTime)
            let time = date?.toString(of: .time)
            headerView.timeLabel.text = time
            headerView.editButtonStackView.isHidden = tabType == .share
            headerView.editButtonStackView.isHidden = indexPath.section != 0 && tabType == .home
            headerView.editModeClosure = {
                self.editMode.toggle()
            }
            
            return headerView
        default:
            assert(false, "헤더 뷰 찾을 수 없음")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 77
        return CGSize(width: width, height: height)
    }
}

// MARK: - CollectionView Delegate

extension CalendarViewController: UICollectionViewDelegate {
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 20, right: 10)
    }
}

extension CalendarViewController: StickerPopUpDelegate {
    func sendStickerDidEnd() {
        print("포스트 요청 성공")
    }
}
