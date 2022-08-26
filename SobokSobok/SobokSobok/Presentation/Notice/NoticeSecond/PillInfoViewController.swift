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
    let dateFormatter = DateFormatter().then {
        $0.dateFormat = FormatType.full.description
    }
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
        getPillDetailInfo(noticeId: self.noticeId, pillId: self.pillId)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12, execute: self.setInfoData)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.isNavigationBarHidden = true
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

    func setInfoData() {        
        let timeCount: Int = pillInfoList?.makeTimeCount() ?? 0
        var startDate = pillInfoList?.startDate ?? ""
        var endDate = pillInfoList?.endDate ?? ""
        startDate = dateFormatter.date(from: startDate)?.toString(of: .noticeDay) ?? ""
        endDate = dateFormatter.date(from: endDate)?.toString(of: .noticeDay) ?? ""
        let interval = pillInfoList?.scheduleSpecific?.changeEnToKr()
        guard let timeArray = pillInfoList?.scheduleTime else { return }
        
        if pillInfoList?.takeInterval == 1 {
            pillInfoView.intervalButton.setTitle("매일", for: .normal)
            pillInfoView.intervalLabel.text = pillInfoList?.scheduleDay
        }
        else if pillInfoList?.takeInterval == 2 {
            pillInfoView.intervalButton.setTitle("특정 요일", for: .normal)
            pillInfoView.intervalLabel.text = pillInfoList?.scheduleDay
        }
        else if pillInfoList?.takeInterval == 3 {
            pillInfoView.intervalButton.setTitle("특정 간격", for: .normal)
            pillInfoView.intervalLabel.text = "\(interval ?? "")"
        }
        else { print("존재하지 않는 case") }

        pillInfoView.titleLabel.text = pillInfoList?.pillName
        pillInfoView.periodLabel.text = "\(startDate) ~ \(endDate)"

        setTimeViews(timeCount: timeCount, timeData: timeArray)
    }

    private func setTimeViews(timeCount: Int, timeData: [String]) {
        if timeCount == 0 {
            [pillInfoView.timeFirstLine, pillInfoView.timeSecondLine].forEach { $0.isHidden = true }
        } else if timeCount <= 3 {
            for index in 0..<timeCount {
                pillInfoView.timeFirstLine.addArrangedSubview(TimeView(time: timeData[index]))
            }
        } else if timeCount > 3 {
            for index in 0..<3 { pillInfoView.timeFirstLine.addArrangedSubview(TimeView(time: timeData[index])) }
            for index in 3..<timeCount { pillInfoView.timeSecondLine.addArrangedSubviews(TimeView(time: timeData[index])) }
        } else {
            fatalError("Wrong Data: Exceeded maximum number of pills.")
        }
    }
}
