//
//  PillInfoViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

final class PillInfoViewController: UIViewController {
    // MARK: - Properties
    var pillInfoList: [PillDetailInfo] = []
    let pillInfoManager: NoticeServiceable = NoticeManager(apiService: APIManager(), environment: .development)
    private let pillInfoView = PillInfoView()
    private let timeView = TimeView()

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
        guard let pillInfo = pillInfoList.first else { return }
        let timeCount = pillInfo.makeTimeCount()
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = Date.FormatType.full.description
//        dateFormatter.date(from: pillInfo.startDate)?.toString(of: .noticeDay)
//        dateFormatter.date(from: pillInfo.endDate)?.toString(of: .noticeDay)
//        let timeArray = pillInfo.scheduleTime.map(<#T##transform: (String) throws -> T##(String) throws -> T#>)
//        dateFormatter.date(from: pillInfo.scheduleTime)?.toString(of: .calendarTime)

        pillInfoView.titleLabel.text = pillInfo.pillName
        pillInfoView.weekLabel.text = "\(pillInfo.takeInterval)주에 한 번"
        pillInfoView.periodLabel.text = "\(pillInfo.startDate) ~ \(pillInfo.endDate)"

        setTimeViews(timeCount: timeCount, timeData: pillInfo.scheduleTime) // TODO: - 시간 변환
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
