//
//  PillInfoViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

final class PillInfoViewController: UIViewController {
    // MARK: - Properties
    var pillInfoList: PillDetailInfo?
    let pillInfoManager: NoticeServiceable = NoticeManager(apiService: APIManager(), environment: .development)
    private let pillInfoView = PillInfoView()
    private let timeView = TimeView()
    var noticeId: Int = 0 {
        didSet {
            setInfoData()
        }
    }
    var pillId: Int = 0 {
        didSet {
            setInfoData()
        }
    }

    // MARK: - View Life Cycle
    override func loadView() {
        view = pillInfoView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        target()
        setInfoData()
    }
}

// MARK: - Extensions
extension PillInfoViewController: NoticeSecondControl {
    func target() {
        pillInfoView.navigationView.navigationButton.addTarget(self, action: #selector(addDismiss), for: .touchUpInside)
    }

    @objc private func addDismiss() {
        self.dismiss(animated: true) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    private func setInfoData() {
        getPillDetailInfo(noticeId: noticeId, pillId: pillId)
        
        guard let pillInfo = pillInfoList?.scheduleTime.first else { return }
        let timeCount = pillInfoList?.makeTimeCount() ?? 0
        var startDate = (pillInfoList?.startDate) ?? ""
        var endDate = (pillInfoList?.endDate) ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = FormatType.full.description
        startDate = dateFormatter.date(from: startDate)?.toString(of: .noticeDay) ?? ""
        endDate = dateFormatter.date(from: endDate)?.toString(of: .noticeDay) ?? ""
        let timeArray = pillInfo.map { dateFormatter.date(from: $0.description)!.toString(of: .calendarTime) }
        let pillName = (pillInfoList?.pillName) ?? ""
        let takeInterval = (pillInfoList?.takeInterval) ?? 0
        
        pillInfoView.titleLabel.text = pillName
        pillInfoView.weekLabel.text = "\(takeInterval)주에 한 번"
        pillInfoView.periodLabel.text = "\(startDate) ~ \(endDate)"

        setTimeViews(timeCount: timeCount, timeData: timeArray)
    }

    private func setTimeViews(timeCount: Int, timeData: [String]) {
        if timeCount == 0 {
            [pillInfoView.timeFirstLine, pillInfoView.timeSecondLine].forEach { $0.isHidden = true }
        } else if timeCount <= 3 {
            for index in 0..<timeCount { pillInfoView.timeFirstLine.addArrangedSubview(TimeView(time: timeData[index])) }
        } else if timeCount > 3 {
            for index in 0..<3 { pillInfoView.timeFirstLine.addArrangedSubview(TimeView(time: timeData[index])) }
            for index in 3..<timeCount { pillInfoView.timeSecondLine.addArrangedSubviews(TimeView(time: timeData[index])) }
        } else {
            fatalError("Wrong Data: Exceeded maximum number of pills.")
        }
    }
}
