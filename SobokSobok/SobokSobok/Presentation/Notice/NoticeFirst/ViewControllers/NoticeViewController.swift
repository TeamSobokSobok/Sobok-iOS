//
//  NoticeViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/09.
//

import UIKit

final class NoticeViewController: BaseViewController {
    
    // MARK: - Properties
    private var noticeList: [NoticeListData] = NoticeListData.dummy
    private let emptyView = EmptyView()
    private let noticeListView = NoticeListView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignDelegation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func loadView() {
//        view = emptyView
        view = noticeListView
    }
    
    override func style() {
        super.style()
        view.backgroundColor = Color.gray150
    }
    
    // MARK: - Functions
    func assignDelegation() {
        noticeListView.noticeListCollectionView.delegate = self
        noticeListView.noticeListCollectionView.dataSource = self
    }
}


// MARK: - Extensions
extension NoticeViewController: UICollectionViewDelegate { }

extension NoticeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = noticeListView.noticeListCollectionView.dequeueReusableCell(for: indexPath, cellType: NoticeListCollectionViewCell.self)
        cell.backgroundColor = Color.white
        cell.makeRounded(radius: 12)
        cell.setData(noticeListData: noticeList[indexPath.row])
        return cell
    }
}
