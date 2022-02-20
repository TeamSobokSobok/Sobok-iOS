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
        cell.layoutIfNeeded()
        cell.accept = { [unowned self] in
            let alert = UIAlertController(title: "지민지민님이 캘린더 공유를 요청했어요", message: "수락하면 상대방이 지안님의 캘린더를\n볼 수 있어요!", preferredStyle: .alert)
            let refuse = UIAlertAction(title: "취소", style: .default, handler: nil)
            let accept = UIAlertAction(title: "확인", style: .default, handler: nil)
            [refuse, accept].forEach {
                alert.addAction($0)
            }
            self.present(alert, animated: true)
        }
        cell.refuse = { [unowned self] in
            let alert = UIAlertController(title: "지민지민님의 캘린더 공유를 거절할까요?", message: "거절하면 상대방이 지안님의 캘린더를\n볼 수 없어요", preferredStyle: .alert)
            let refuse = UIAlertAction(title: "취소", style: .default, handler: nil)
            let accept = UIAlertAction(title: "확인", style: .default, handler: nil)
            [refuse, accept].forEach {
                alert.addAction($0)
            }
            self.present(alert, animated: true)
        }
        return cell
    }
}
