//
//  CalendarViewController+CollectionViewDataSource.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/18.
//

import UIKit

// MARK: - CollectionView

extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource {    
    /// section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        pillItems.count
        3
    }
    
    /// row in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            for: indexPath, cellType: MedicineCollectionViewCell.self
        )
        
        cell.contentView.backgroundColor = Color.white
        cell.contentView.makeRounded(radius: 12)
        cell.pillName.text = "약 이름 테스트"
        
        cell.editButton.isHidden = !editMode
        cell.checkButton.isHidden = editMode
        
        cell.stickerClosure = { [weak self] in
            guard let self = self else { return }
            self.showStickerBottomSheet()
        }
        
        cell.editClosure = {
            self.showActionSheet()
        }
        
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
            
            headerView.editButtonStackView.isHidden = indexPath.section != 0
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
