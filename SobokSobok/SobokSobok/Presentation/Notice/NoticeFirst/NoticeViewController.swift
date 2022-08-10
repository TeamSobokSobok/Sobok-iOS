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
        let userName = (noticeList?.userName) ?? ""
        let groupName = (noticeList?.infoList[indexPath.row].senderName) ?? ""
        let createdAt = noticeList?.infoList[indexPath.row].createdAt
        
        noticeListView.titleLabel.text = "소중한 " + userName + "님의 알림"
        
        let cell = noticeListView.noticeListCollectionView.dequeueReusableCell(for: indexPath, cellType: NoticeListCollectionViewCell.self)
        
        if cell.sectionType == .calender {
            if noticeList?.infoList[indexPath.row].isOkay == "wait" {
                cell.nameLabel.text = groupName
                cell.infoLabel.text = groupName + "님이 친구를 신청했어요"
                cell.timeLabel.text = createdAt
                cell.accept = { [weak self] in
                    makeAlert(
                        title: groupName + "님의 친구 신청을 수락할까요?",
                        message: "수락하면 상대방이 내 캘린더를 볼 수 있어요",
                        accept: "확인",
                        viewController: self) {
                            cell.statusType = .done
                            cell.infoLabel.text = groupName + "님의 친구 신청을 수락했어요"
                            cell.timeLabel.text = createdAt // TODO: - 형식 변환
                        }
                    cell.statusType = .waite
                }
                cell.refuse = { [weak self] in
                    makeAlert(
                        title: groupName + "님의 친구 신청을 수락할까요?",
                        message: "거절하면 상대방이 내 캘린더를 볼 수 없어요",
                        accept: "확인",
                        viewController: self) {
                            cell.statusType = .done
                            cell.infoLabel.text = groupName + "님의 친구 신청을 거절했어요"
                            cell.timeLabel.text = createdAt // TODO: - 형식 변환
                        }
                    cell.statusType = .waite
                }
            }
            else if noticeList?.infoList[indexPath.row].isOkay == "accept" {
                
            }
            else { }
        }
        else if cell.sectionType == .pill {
            cell.nameLabel.text = noticeList?.infoList[indexPath.row].pillName
            cell.infoLabel.text = groupName + "님이 약 일정을 보냈어요"
            cell.timeLabel.text = createdAt
            cell.info = { [weak self] in
                let nextViewController = PillInfoViewController.instanceFromNib()
                self?.navigationController?.pushViewController(nextViewController, animated: true)
            }
            cell.accept = { [weak self] in
                makeAlert(
                    title: "이 약을 수락할까요?",
                    message: "수락하면 홈 캘린더에 약이 추가되고,\n정해진 시간에 알림을 받을 수 있어요 ",
                    accept: "확인",
                    viewController: self) {
                        if acceptedPillCount <= 5 {
                            cell.statusType = .done
                            cell.infoLabel.text = groupName + "님이 보낸 약 알림 일정을 수락했어요"
                            // TODO: - 서버통신
                            cell.timeLabel.text = createdAt // TODO: - 시간으로 형식 변환
                            acceptedPillCount += 1
                        }
                        else if acceptedPillCount == 5 {
                           makeAcceptAlert(
                            title: "이미 5개의 약을 복약 중이에요!",
                            message: "약은 최대 5개까지만 추가 가능해요"
                           ) {
                               cell.statusType = .done
                               cell.infoLabel.text = groupName + "님이 보낸 약 알림 일정을 거절했어요"
                               // TODO: - 서버통신
                               cell.timeLabel.text = createdAt // TODO: - 형식 변환
                           }
                        }
                        else {
                            fatalError()
                        }
                    }
                cell.statusType = .waite
            }
            cell.refuse = { [weak self] in
                makeAlert(
                    title: "이 약을 거절할까요?",
                    message: "거절하면 해당 약 알림을 받을 수 없어요",
                    accept: "확인",
                    viewController: self) {
                        // TODO: - 서버통신
                        cell.statusType = .done
                        cell.infoLabel.text = groupName + "님이 보낸 약 알림 일정을 거절했어요"
                        cell.timeLabel.text = createdAt // TODO: - 형식 변환
                    }
                cell.statusType = .waite
            }
        }
        else {
            assert(indexPath.isEmpty, "어떤 상태도 아님 (데이터 안 담겼음)")
        }
        return cell
    }
 }
