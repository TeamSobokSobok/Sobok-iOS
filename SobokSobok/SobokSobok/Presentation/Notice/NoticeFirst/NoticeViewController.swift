//
//  NoticeViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/09.
//

import UIKit

final class NoticeViewController: UIViewController {
    // MARK: - Properties
    var noticeList: NoticeList? {
        didSet {
            noticeListView.noticeListCollectionView.reloadData()
        }
    }
    let noticeListManager: NoticeServiceable = NoticeManager(apiService: APIManager(), environment: .development)
    private let noticeListView = NoticeListView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = noticeListView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        getNoticeList()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
}

// MARK: - Extensions
extension NoticeViewController: NoticeFistControl {
    func assignDelegation() {
       noticeListView.noticeListCollectionView.collectionViewLayout = createSection()
        noticeListView.noticeListCollectionView.delegate = self
        noticeListView.noticeListCollectionView.dataSource = self
    }
 }

 extension NoticeViewController: UICollectionViewDelegate { }

 extension NoticeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if noticeList?.infoList.isEmpty == true {
            collectionView.setEmptyView(image: Image.illustOops, message: "아직 도착한 알림이 없어요!")
        } else { collectionView.restore() }

        return noticeList?.infoList.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        noticeListView.titleLabel.text = "소중한 \(String(describing: noticeList?.userName))님의 알림"
        let cell = noticeListView.noticeListCollectionView.dequeueReusableCell(for: indexPath, cellType: NoticeListCollectionViewCell.self)
        cell.nameLabel.text = noticeList?.infoList[indexPath.row].pillName
        cell.infoLabel.text = "\(String(describing: noticeList?.infoList[indexPath.row].senderName))님이 약 일정을 보냈어요"
        cell.timeLabel.text = noticeList?.infoList[indexPath.row].createdAt // TODO: - 시간 가공
        cell.info = { [weak self] in
            let nextViewController = PillInfoViewController.instanceFromNib()
            self?.navigationController?.pushViewController(nextViewController, animated: true)
        }
        cell.accept = { [weak self] in
            makeAlert(
                title: "이 약을 수락할까요?",
                message: "수락하면 홈 캘린더에 약이 추가되고,\n정해진 시간에 알림을 받을 수 있어요 ",
                accept: "확인",
                viewController: self)
            cell.statusType = .done
        }
        cell.refuse = { [weak self] in
            makeAlert(
                title: "이 약을 거절할까요?",
                message: "거절하면 해당 약 알림을 받을 수 없어요",
                accept: "확인",
                viewController: self)
            cell.statusType = .done
        }
        return cell
    }
 }
