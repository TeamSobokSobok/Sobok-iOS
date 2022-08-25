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
            self.noticeListView.noticeListCollectionView.reloadData()
        }
    }
    var friendInfo: AcceptFriend? {
        didSet {
            self.noticeListView.noticeListCollectionView.reloadData()
        }
    }
    let noticeListManager: NoticeServiceable = NoticeManager(apiService: APIManager(), environment: .development)
    private lazy var sendedPillCount: Int = 0
    private let noticeListView = NoticeListView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = noticeListView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        getNoticeList()
    }
}

// MARK: - Extensions
extension NoticeViewController: NoticeFistControl {
    func assignDelegation() {
        noticeListView.noticeListCollectionView.collectionViewLayout = createSection()
        noticeListView.noticeListCollectionView.dataSource = self
    }
}
extension NoticeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if noticeList?.infoList.isEmpty == true {
            collectionView.setEmptyView(
                image: Image.illustOops, message: "아직 도착한 알림이 없어요!"
            )
        } else { collectionView.restore() }
        
        return noticeList?.infoList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let userName = (noticeList?.userName) ?? ""
        let groupName = (noticeList?.infoList[indexPath.row].senderName) ?? ""
        let pillName = (noticeList?.infoList[indexPath.row].pillName) ?? ""
        var createdAt = (noticeList?.infoList[indexPath.row].createdAt) ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormatType.full.description
        
        noticeListView.titleLabel.text = "소중한 " + userName + "님의 알림"
        
        let cell = noticeListView.noticeListCollectionView.dequeueReusableCell(
            for: indexPath, cellType: NoticeListCollectionViewCell.self
        )
        
        // 약 / 캘린더인지 --> waiting / accept, refuse
        // pillName / senderName
        // senderName
        // 시간
        // 거절 / 수락 --> PUT 통신 --> senderName, 시간
        
        if noticeList?.infoList[indexPath.row].isOkay == "waiting" {
            createdAt = dateFormatter.date(from: createdAt)?.toString(of: .calendarTime) ?? ""
            cell.timeLabel.text = "\(createdAt)"
            
            if noticeList?.infoList[indexPath.row].section == "calendar" {
                cell.setupView(section: .calender, status: .waite)
                cell.nameLabel.text = "\(groupName)"
                cell.descriptionLabel.text = "\(groupName)님이 친구를 신청했어요"
                
                cell.refuse = { [weak self] in
                    self?.makeRefuseAlert(
                        title: "\(groupName)님의 친구 신청을 거절할까요?",
                        message: "거절하면 상대방이 내 캘린더를 볼 수 없어요",
                        completion: {
                            self?.putAcceptFriend(
                                for: self?.noticeList?.infoList[indexPath.row].noticeId ?? 0,
                                status: "refuse")
                            self?.noticeListView.noticeListCollectionView.reloadData()
                            // -- 이쪽 부분
                        })
                }
                cell.accept = { [weak self] in
                    self?.makeAlert(
                        title: "\(groupName)님의 친구 신청을 수락할까요?",
                        message: "수락하면 상대방이 내 캘린더를 볼 수 있어요",
                        completion: {
                            self?.putAcceptFriend(
                                for: self?.noticeList?.infoList[indexPath.row].noticeId ?? 0,
                                status: "accept")
                        })
                }
            }
            else if noticeList?.infoList[indexPath.row].section == "pill" {
                cell.setupView(section: .pill, status: .waite)
                cell.nameLabel.text = "\(pillName)"
                cell.descriptionLabel.text = "\(groupName)님이 보낸 약 알림 일정을 보냈어요"
                
                cell.info = { [weak self] in
                    let pillInfoViewController = PillInfoViewController.instanceFromNib()
                    pillInfoViewController.noticeId = self?.noticeList?.infoList[indexPath.row].noticeId ?? 0
                    pillInfoViewController.pillId = self?.noticeList?.infoList[indexPath.row].pillId ?? 0
                    self?.navigationController?.pushViewController(pillInfoViewController, animated: false)
                }
                cell.refuse = { [weak self] in
                    self?.makeRefuseAlert(
                        title: "이 약을 거절할까요?",
                        message: "거절하면 해당 약 알림을 받을 수 없어요",
                        completion: {
                            self?.putAcceptPill(
                                for: self?.noticeList?.infoList[indexPath.row].pillId ?? 0,
                                status: "refuse")
                        })
                    
                }
                cell.accept = { [weak self] in
                    self?.makeAlert(
                        title: "이 약을 수락할까요?",
                        message: "수락하면 홈 캘린더에 약이 추가되고,\n정해진 시간에 알림을 받을 수 있어요",
                        completion: {
                            self?.putAcceptFriend(
                                for: self?.noticeList?.infoList[indexPath.row].pillId ?? 0,
                                status: "accept")
                        })
                }
            }
            else { fatalError("발생할 수 없는 case") }
        }
        else {
            createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
            cell.timeLabel.text = "\(createdAt)"
            
            if noticeList?.infoList[indexPath.row].isOkay == "accept" {
                if noticeList?.infoList[indexPath.row].section == "calendar" {
                    cell.setupView(section: .calender, status: .done)
                    cell.nameLabel.text = "\(groupName)"
                    cell.descriptionLabel.text = "\(groupName)님의 친구 신청을 수락했어요"
                }
                else if noticeList?.infoList[indexPath.row].section == "pill" {
                    cell.setupView(section: .pill, status: .done)
                    cell.nameLabel.text = "\(pillName)"
                    cell.descriptionLabel.text = "\(groupName)님이 보낸 약 알림 일정을 수락했어요"
                }
                else { fatalError("발생할 수 없는 case") }
            }
            else if noticeList?.infoList[indexPath.row].isOkay == "refuse" {
                if noticeList?.infoList[indexPath.row].section == "calendar" {
                    cell.setupView(section: .calender, status: .done)
                    cell.nameLabel.text = "\(groupName)"
                    cell.descriptionLabel.text = "\(groupName)님의 친구 신청을 거절했어요"
                }
                else if noticeList?.infoList[indexPath.row].section == "pill" {
                    cell.setupView(section: .pill, status: .done)
                    cell.nameLabel.text = "\(pillName)"
                    cell.descriptionLabel.text = "\(groupName)님이 보낸 약 알림 일정을 거절했어요"
                }
                else { fatalError("발생할 수 없는 case") }
            }
            else { fatalError("발생할 수 없는 case") }
        }
        
        return cell
    }
}
