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
        
        addDissmiss()
        assignDelegation()
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
            self.dismiss(animated: true, completion: nil)
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
        guard let footer = pillInfoView.pillInfoCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PillInfoFooterView.reuseIdentifier, for: indexPath) as? PillInfoFooterView else { return UICollectionReusableView() }
        return footer
    }
}
