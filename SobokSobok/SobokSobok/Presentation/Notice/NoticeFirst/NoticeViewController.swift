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
        addObservers()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        getNoticeList()
    }
    deinit {
        removeObservers()
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
        
        if noticeList?.infoList[indexPath.row].isOkay == "waiting" {
            createdAt = dateFormatter.date(from: createdAt)?.toString(of: .calendarTime) ?? ""
            cell.timeLabel.text = "\(createdAt)"
            
            if noticeList?.infoList[indexPath.row].section == "calendar" {
                cell.setupView(section: .calender, status: .waite)
                cell.nameLabel.text = "\(groupName)"
                cell.descriptionLabel.text = "\(groupName)님이 친구를 신청했어요"
                
                cell.refuse = { [weak self] in
                    guard let self = self else { return }
                    self.makeAlert(
                        title: "\(groupName)님의 친구 신청을 거절할까요?",
                        message: "거절하면 상대방이 내 캘린더를 볼 수 없어요",
                        completion: {
                            Notification.Name.requestFriend.post(
                                object: nil,
                                userInfo: [
                                    "sendGroupId": self.noticeList?.infoList[indexPath.row].noticeId ?? 0,
                                    "isOkay": "refuse"
                                ]
                            )
                        })
                }
                cell.accept = { [weak self] in
                    guard let self = self else { return }
                    self.makeAlert(
                        title: "\(groupName)님의 친구 신청을 수락할까요?",
                        message: "수락하면 상대방이 내 캘린더를 볼 수 있어요",
                        completion: {
                            Notification.Name.requestFriend.post(
                                object: nil,
                                userInfo: [
                                    "sendGroupId": self.noticeList?.infoList[indexPath.row].noticeId ?? 0,
                                    "isOkay": "accept"
                                ]
                            )
                        })
                }
            }
            else if noticeList?.infoList[indexPath.row].section == "pill" {
                cell.setupView(section: .pill, status: .waite)
                cell.nameLabel.text = "\(pillName)"
                cell.descriptionLabel.text = "\(groupName)님이 보낸 약 알림 일정을 보냈어요"
                
                if UserDefaults.standard.integer(forKey: "sendedPillCount") == 0 {
                    cell.toolTipView.isHidden = false
                }
                else {
                    cell.toolTipView.isHidden = true
                    cell.toolTipView.removeFromSuperview()
                }
                
                cell.info = { [weak self] in
                    let pillInfoViewController = PillInfoViewController.instanceFromNib()
                    pillInfoViewController.noticeId = self?.noticeList?.infoList[indexPath.row].noticeId ?? 0
                    pillInfoViewController.pillId = self?.noticeList?.infoList[indexPath.row].pillId ?? 0
                    self?.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
                    self?.navigationController?.pushViewController(pillInfoViewController, animated: true)
                }
                cell.refuse = { [weak self] in
                    guard let self = self else { return }
                    self.makeAlert(
                        title: "이 약을 거절할까요?",
                        message: "거절하면 해당 약 알림을 받을 수 없어요",
                        completion: {
                            Notification.Name.requestPill.post(
                                object: nil,
                                userInfo: [
                                    "pillId": self.noticeList?.infoList[indexPath.row].pillId ?? 0,
                                    "isOkay": "refuse"
                                ]
                            )
                        })
                    
                }
                cell.accept = { [weak self] in
                    guard let self = self else { return }
                    
                    self.makeAlert(
                        title: "이 약을 수락할까요?",
                        message: "수락하면 홈 캘린더에 약이 추가되고,\n정해진 시간에 알림을 받을 수 있어요",
                        completion: {
                            Notification.Name.requestPill.post(
                                object: nil,
                                userInfo: [
                                    "pillId": self.noticeList?.infoList[indexPath.row].pillId ?? 0,
                                    "isOkay": "accept"
                                ]
                            )
                        })
                    
                    if UserDefaults.standard.integer(forKey: "sendedPillCount") == 5 {
                        self.makeRefuseAlert(
                            title: "이미 5개의 약을 복약 중이에요!",
                            message: "약은 최대 5개까지만 추가 가능해요") {
                                Notification.Name.requestPill.post(
                                    object: nil,
                                    userInfo: [
                                        "pillId": self.noticeList?.infoList[indexPath.row].pillId ?? 0,
                                        "isOkay": "refuse"
                                    ]
                                )
                            }
                    }
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

extension NoticeViewController {
    private func addObservers() {
        requestFriendObserver()
        requestPillObserver()
    }
    private func removeObservers() {
        Notification.Name.requestFriend.removeObserver(observer: self)
        Notification.Name.requestPill.removeObserver(observer: self)
    }
    
    private func requestFriendObserver() {
        Notification.Name.requestFriend.addObserver { [weak self] notification in
            guard let self = self else { return }
            if let notification = notification.userInfo,
               let sendGroupId = notification["sendGroupId"] as? Int,
               let isOkay = notification["isOkay"] as? String {
                
                if isOkay == "accept" || isOkay == "refuse" {
                    self.putAcceptFriend(for: sendGroupId, status: isOkay)
                }
                else {
                    return
                }
            }
        }
    }
    private func requestPillObserver() {
        Notification.Name.requestPill.addObserver { [weak self] notification in
            guard let self = self else { return }
            if let notification = notification.userInfo,
               let pillId = notification["pillId"] as? Int,
               let isOkay = notification["isOkay"] as? String {
                
                if isOkay == "accept" {
                    if self.sendedPillCount < 5 {
                        self.sendedPillCount += 1
                    }
                    UserDefaults.standard.set(self.sendedPillCount, forKey: "sendedPillCount")
                    self.putAcceptPill(for: pillId, status: isOkay)
                }
                else if isOkay == "refuse" {
                    self.putAcceptPill(for: pillId, status: isOkay)
                }
                else {
                    return
                }
            }
        }
    }
}
