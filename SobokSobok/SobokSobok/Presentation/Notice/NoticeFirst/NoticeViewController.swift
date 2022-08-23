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
    var friendStatus: [Bool: String] = [
        true: "accept",
        false: "refuse"
    ]
    var pillStatus: [Bool: String] = [
        true: "accept",
        false: "refuse"
    ]
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
        var createdAt = (noticeList?.infoList[indexPath.row].createdAt) ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormatType.full.description
        
        noticeListView.titleLabel.text = "소중한 " + userName + "님의 알림"
        
        let cell = noticeListView.noticeListCollectionView.dequeueReusableCell(
            for: indexPath, cellType: NoticeListCollectionViewCell.self
        )
        
        if noticeList?.infoList[indexPath.row].section == "calendar" {
            if noticeList?.infoList[indexPath.row].isOkay == "waiting" {
                cell.setupView(section: .calender, status: .waite)
                
                createdAt = dateFormatter.date(from: createdAt)?.toString(of: .calendarTime) ?? ""
                cell.nameLabel.text = groupName
                cell.descriptionLabel.text = groupName + "님이 친구를 신청했어요"
                cell.timeLabel.text = createdAt
                
                cell.accept = { [weak self] in
                    createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
                    makeAlert(
                        title: groupName + "님의 친구 신청을 수락할까요?",
                        message: "수락하면 상대방이 내 캘린더를 볼 수 있어요",
                        accept: "확인",
                        viewController: self) { [weak self] in
                            if self?.becomeFirstResponder() == true {
                                self?.putAcceptFriend(
                                    status: self?.friendStatus[true] ?? "",
                                    at: self?.friendInfo?.sendGroupId ?? 0
                                )
                                cell.setupView(section: .calender, status: .done)
                                createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
                                cell.descriptionLabel.text = groupName + "님의 친구 신청을 수락했어요"
                                cell.timeLabel.text = createdAt
                            } else {
                                cell.setupView(section: .calender, status: .waite)
                            }
                        }
                }
                cell.refuse = { [weak self] in
                    createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
                    makeAlert(
                        title: groupName + "님의 친구 신청을 거절할까요?",
                        message: "거절하면 상대방이 내 캘린더를 볼 수 없어요",
                        accept: "확인",
                        viewController: self) { [weak self] in
                            if self?.becomeFirstResponder() == true {
                                self?.putAcceptFriend(
                                    status: self?.friendStatus[false] ?? "",
                                    at: self?.friendInfo?.sendGroupId ?? 0
                                )
                                cell.setupView(section: .calender, status: .done)
                                createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
                                cell.descriptionLabel.text = groupName + "님의 친구 신청을 거절했어요"
                                cell.timeLabel.text = createdAt
                            } else {
                                cell.setupView(section: .calender, status: .waite)
                            }
                        }
                }
            }
            else if noticeList?.infoList[indexPath.row].isOkay == "accept" {
                cell.setupView(section: .calender, status: .done)
                
                createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
                cell.descriptionLabel.text = groupName + "님의 친구 신청을 수락했어요"
                cell.timeLabel.text = createdAt
            }
            else if noticeList?.infoList[indexPath.row].isOkay == "refuse" {
                cell.setupView(section: .calender, status: .done)
                
                createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
                cell.descriptionLabel.text = groupName + "님의 친구 신청을 거절했어요"
                cell.timeLabel.text = createdAt
            }
            else { fatalError("존재하지 않는 case") }
        }
        else if noticeList?.infoList[indexPath.row].section == "pill" {
            if noticeList?.infoList[indexPath.row].isOkay == "waiting" {
                cell.setupView(section: .pill, status: .waite)
                
                if acceptedPillCount == 0 {
                    cell.toolTipView.isHidden = false
                    cell.toolTipView.layer.duration = 5.0
                    cell.toolTipView.isHidden.toggle()
                }
                
                createdAt = dateFormatter.date(from: createdAt)?.toString(of: .calendarTime) ?? ""
                cell.nameLabel.text = noticeList?.infoList[indexPath.row].pillName
                cell.descriptionLabel.text = groupName + "님이 약 일정을 보냈어요"
                cell.timeLabel.text = createdAt
                
                cell.info = { [weak self] in
                    let nextViewController = PillInfoViewController.instanceFromNib()
                    nextViewController.noticeId = self?.noticeList?.infoList[indexPath.row].noticeId ?? 0
                    nextViewController.pillId = self?.noticeList?.infoList[indexPath.row].pillId ?? 0
                    self?.navigationController?.pushViewController(nextViewController, animated: true)
                }
                
                cell.accept = { [weak self] in
                    makeAlert(
                        title: "이 약을 수락할까요?",
                        message: "수락하면 홈 캘린더에 약이 추가되고,\n정해진 시간에 알림을 받을 수 있어요 ",
                        accept: "확인",
                        viewController: self)  { [weak self] in
                            if self?.becomeFirstResponder() == true {
                                if acceptedPillCount < 5 {
                                    cell.setupView(section: .pill, status: .done)
                                    createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
                                    cell.descriptionLabel.text = groupName + "님이 보낸 약 알림 일정을 수락했어요"
                                    self?.putAcceptPill(
                                        status: self?.pillStatus[true] ?? "",
                                        at: self?.noticeList?.infoList[indexPath.row].pillId ?? 0
                                    )
                                    cell.timeLabel.text = createdAt
                                    
                                    acceptedPillCount += 1
                                }
                                else if acceptedPillCount == 5 {
                                    makeAcceptAlert(
                                        title: "이미 5개의 약을 복약 중이에요!",
                                        message: "약은 최대 5개까지만 추가 가능해요") { [weak self] in
                                            if self?.becomeFirstResponder() == true {
                                                cell.setupView(section: .pill, status: .done)
                                                createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
                                                cell.descriptionLabel.text = groupName + "님이 보낸 약 알림 일정을 거절했어요"
                                                self?.putAcceptPill(
                                                    status: self?.pillStatus[false] ?? "",
                                                    at: self?.noticeList?.infoList[indexPath.row].pillId ?? 0
                                                )
                                                cell.timeLabel.text = createdAt
                                            } else { fatalError("존재하지 않는 case") }
                                        }
                                }
                                else {
                                    fatalError("존재하지 않는 case")
                                }
                            }
                            else {
                                cell.setupView(section: .calender, status: .waite)
                            }
                        }
                }
                cell.refuse = { [weak self] in
                    createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
                    makeAlert(
                        title: "이 약을 거절할까요?",
                        message: "거절하면 해당 약 알림을 받을 수 없어요",
                        accept: "확인",
                        viewController: self) { [weak self] in
                            if self?.becomeFirstResponder() == true {
                                cell.setupView(section: .pill, status: .done)
                                createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
                                cell.descriptionLabel.text = groupName + "님이 보낸 약 알림 일정을 거절했어요"
                                self?.putAcceptPill(
                                    status: self?.pillStatus[false] ?? "",
                                    at: self?.noticeList?.infoList[indexPath.row].pillId ?? 0
                                )
                                cell.timeLabel.text = createdAt
                            }
                            else {
                                cell.setupView(section: .pill, status: .waite)
                            }
                        }
                }
                
            }
            else if noticeList?.infoList[indexPath.row].isOkay == "accept" {
                cell.setupView(section: .pill, status: .done)
                
                createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
                cell.descriptionLabel.text = groupName + "님이 보낸 약 알림 일정을 수락했어요"
                cell.timeLabel.text = createdAt
            }
            else if noticeList?.infoList[indexPath.row].isOkay == "refuse" {
                cell.setupView(section: .pill, status: .done)
                
                createdAt = dateFormatter.date(from: createdAt)?.toString(of: .noticeDay) ?? ""
                cell.descriptionLabel.text = groupName + "님이 보낸 약 알림 일정을 거절했어요"
                cell.timeLabel.text = createdAt
            }
            else { fatalError("존재하지 않는 case") }
            
        }
        else {
            assert(indexPath.isEmpty, "어떤 상태도 아님 (데이터 안 담겼음)")
        }
        return cell
    }
}
