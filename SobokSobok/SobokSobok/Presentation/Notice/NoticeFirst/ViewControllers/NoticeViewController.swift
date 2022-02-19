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
        if noticeList.count == 0 {
            collectionView.setEmptyView(title: "소중한 지안님의 알림", image: Image.illustOops, message: "아직 도착한 알림이 없어요!")
        }
        else {
            collectionView.restore()
        }
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
