//
//  ScheduleDataSource.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/22.
//

import UIKit

enum ScheduleType: String {
    case main
    case share
}

// MARK: - UICollectionViewDataSource

final class ScheduleDataSource: NSObject, UICollectionViewDataSource {

    typealias PillSchedules = [PillList]
    
    
    // MARK: - Properties
    
    private var pillSchedules: PillSchedules
    private var scheduleType: ScheduleType
    private var viewController: ScheduleViewController
    
    
    // MARK: - UI Properties
    
    lazy var emptyView = ScheduleEmptyView(for: scheduleType)

    
    // MARK: - Initializer
    
    init(
        pillSchedules: PillSchedules,
        scheduleType: ScheduleType,
        viewController: ScheduleViewController
    ) {
        self.pillSchedules = pillSchedules
        self.scheduleType = scheduleType
        self.viewController = viewController
        super.init()
    }
    
    
    // MARK: - CollectionView Methods

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionView.backgroundView = pillSchedules.isEmpty ? emptyView : nil
        return pillSchedules.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pillSchedules[section].scheduleList?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let pill = pillSchedules[indexPath.section].scheduleList?[indexPath.row] else {
            return UICollectionViewCell()
        }
        let stickerId = pill.stickerId?.map { $0.stickerId }
        let stickerList = pill.stickerList?.map { $0.stickerId }

        switch scheduleType {
        case .main:
            let mainCell = collectionView.dequeueReusableCell(for: indexPath, cellType: MainScheduleCell.self)
            mainCell.configure(withPill: pill)
            mainCell.isChecked = pill.isCheck
            mainCell.currentDate = viewController.currentDate
            mainCell.delegate = viewController
            mainCell.configure(withSticker: stickerId)
            return mainCell
            
        case .share:
            let shareCell = collectionView.dequeueReusableCell(for: indexPath, cellType: ShareScheduleCell.self)
            shareCell.configure(withPill: pill)
            shareCell.configure(with: (isLiked: pill.isLikedSchedule ?? false, isEat: pill.isCheck))
            shareCell.configure(withSticker: stickerList)
            shareCell.stateView.emotionClosure = { [weak self] in
                self?.viewController.getStickers(for: pill.scheduleId) {
                    let stickers = self?.viewController.stickers.filter { $0.isMySticker == true }.map { $0.likeScheduleId }
                    self?.viewController.showStickerPopUp(scheduleId: pill.scheduleId, isLikedSchedule: pill.isLikedSchedule ?? false, likeScheduleId: stickers?.first ?? 0)
                }
            }
            return shareCell
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: ScheduleHeaderView.reuseIdentifier,
            for: indexPath
        ) as? ScheduleHeaderView else {
            return UICollectionReusableView()
        }
        
        switch scheduleType {
        case .main:
            let isHidden = indexPath.section != 0
            headerView.showEditButton(isHidden: isHidden)
            
        case .share:
            headerView.showEditButton(isHidden: true)
        }
        
        let scheduleTime = pillSchedules[indexPath.section].scheduleTime
        headerView.configure(withTime: scheduleTime)
        return headerView
    }
}


// MARK: - Public Methods

extension ScheduleDataSource {
    
    func update(with pillSchedules: PillSchedules) {
        self.pillSchedules = pillSchedules
    }
}
