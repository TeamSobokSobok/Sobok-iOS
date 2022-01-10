//
//  NoticeViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/09.
//

import UIKit

final class NoticeViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    @IBOutlet var notificationTableView: UITableView!
    
    // MARK: - Properties
    var noticeList: [NoticeListData] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        registerXib()
        setTableView()
        initNoticeList()
    }
    
    // MARK: - Functions
    func assignDelegation() {
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
    }
    
    func setTableView() {
        notificationTableView.rowHeight = UITableView.automaticDimension
    }
    
    func registerXib() {
        notificationTableView.register(UINib(nibName: NoticeTableViewCell.cellIdentifier, bundle: nil), forCellReuseIdentifier: NoticeTableViewCell.cellIdentifier)
    }
    
    func initNoticeList() {
        noticeList.append(contentsOf: [
            NoticeListData(noticeImageName: "icCalendarAlarmMint", noticeTitle: "지민지민님이 캘린더 공유를 요청했어요", noticeTime: "오후 12:35"),
            NoticeListData(noticeImageName: "icFillAlarmMint", noticeTitle: "수현이님이 복약 정보를 전송했어요", noticeTime: "오전 10:40"),
            NoticeListData(noticeImageName: "icFillAlarmGray", noticeTitle: "효영님의 약 전송을 거절했어요", noticeTime: "오전 8:21"),
            NoticeListData(noticeImageName: "icFillAlarmMint", noticeTitle: "나는야효영이라네로를님이 복약 정보를 전송했어요", noticeTime: "2022.01.06"),
            NoticeListData(noticeImageName: "icFillAlarmGray", noticeTitle: "나는야효영이라네로를님의 약 전송을 거절했어요", noticeTime: "2022.01.06")
        ])
    }
}

// MARK: - Extensions
extension NoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = notificationTableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.cellIdentifier) as? NoticeTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.setData(noticeData: noticeList[indexPath.row])
        switch indexPath.row {
        case 2:
            cell.confirmButton.subviews.forEach { $0.isHidden = true }
        case 4:
            cell.confirmButton.subviews.forEach { $0.isHidden = true }
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
        default:
            cell.confirmButton.subviews.forEach { $0.isHidden = false }
        }
        return cell
    }
}

extension NoticeViewController: UITableViewDelegate { }

