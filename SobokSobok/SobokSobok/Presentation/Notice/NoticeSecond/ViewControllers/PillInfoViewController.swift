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
        
        assignDelegation()
    }
    
    override func loadView() {
        view = pillInfoView
    }
    
    // MARK: - Functions
    func assignDelegation() {
        pillInfoView.pillInfoCollectionView.delegate = self
        pillInfoView.pillInfoCollectionView.dataSource = self
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
}
