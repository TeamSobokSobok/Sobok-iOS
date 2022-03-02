//
//  SendInfoViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

final class PillInfoViewController: UIViewController {
    
    // MARK: - Properties
    private var pillInfoList: [SendInfoListData] = SendInfoListData.dummy
    private let pillInfoView = PillInfoView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        acceptButtonClicked()
        addDissmiss()
        assignDelegation()
        refuseButtonClicked()
    }
    
    override func loadView() {
        view = pillInfoView
    }
    
    // MARK: - Functions
    private func assignDelegation() {
        pillInfoView.pillInfoCollectionView.delegate = self
        pillInfoView.pillInfoCollectionView.dataSource = self
    }
    
    private func addDissmiss() {
        pillInfoView.closed = { [unowned self] in
            self.dismiss(animated: true)
        }
    }
    
    private func refuseButtonClicked() {
        pillInfoView.sendedPillRefuse = { [unowned self] in
            self.dismiss(animated: true) {
                // TODO: - 서버통신 후 처리 (NoticdListView의 Cell 바뀌도록)
            }
        }
    }
    
    private func acceptButtonClicked() {
        pillInfoView.sendedPillAccept = { [unowned self] in
            makeAcceptAlert(title: "복약 중인 약을 포함해\n최대 5개까지 저장할 수 있어요", vc: self) {
                // TODO: - 서버통신 후 처리 (NoticdListView의 Cell 바뀌도록)
            }
        }
    }
}

// MARK: - Extensions
extension PillInfoViewController: UICollectionViewDelegate { }

extension PillInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pillInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pillInfoView.pillInfoCollectionView.dequeueReusableCell(for: indexPath, cellType: PillInfoCollectionViewCell.self)
        cell.setData(pillInfoData: pillInfoList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let header = pillInfoView.pillInfoCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PillInfoHeaderView.reuseIdentifier, for: indexPath) as? PillInfoHeaderView else { return UICollectionReusableView() }
            return header
        case UICollectionView.elementKindSectionFooter:
            guard let footer = pillInfoView.pillInfoCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PillInfoFooterView.reuseIdentifier, for: indexPath) as? PillInfoFooterView else { return UICollectionReusableView() }
            return footer
        default:
            assert(false)
        }
    }
}
