//
//  NoticeViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/09.
//

import UIKit

final class NoticeViewController: BaseViewController {

    // MARK: - @IBOutlet Properties
    @IBOutlet var notificationTableView: UITableView!
    
    // MARK: - Properties
    private var noticeList: [NoticeListData] = NoticeListData.dummy
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        registerXib()
        setTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
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
        notificationTableView.register(NoticeTableViewCell.self)
    }
}

// MARK: - Extensions
extension NoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificationTableView.dequeueReusableCell(for: indexPath, cellType: NoticeTableViewCell.self)
        cell.selectionStyle = .none
        cell.setData(noticeData: noticeList[indexPath.row])
        cell.index = indexPath.row
        cell.delegate = self
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

extension NoticeViewController: ComponentProductCellDelegate {
    func selectedInfoButton(index: Int) {
        let nextVC = SendInfoViewController.instanceFromNib()
        self.present(nextVC, animated: true)
    }
}
