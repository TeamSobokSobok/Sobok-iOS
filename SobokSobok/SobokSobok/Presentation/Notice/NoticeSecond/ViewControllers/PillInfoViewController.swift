//
//  PillInfoViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

final class PillInfoViewController: BaseViewController {
    
    // MARK: - Properties
    private var pillInfoList: [SendInfoData] = SendInfoData.dummy
    private let pillInfoView = PillInfoView()
    private let timeView = TimeView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = pillInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setInfoData()
    }
    
    // MARK: - Functions
    override func target() {
        pillInfoView.navigationView.navigationButton.addTarget(self, action: #selector(addDismiss), for: .touchUpInside)
    }
}

// MARK: - Extensions
extension PillInfoViewController {
    @objc private func addDismiss() { self.dismiss(animated: true) }
    
    private func setInfoData() {
        // TODO: - 서버통신 할 때는 setInfoData(data: pillInfoList[pillNumber]) 로 바꾸기
        guard let pillInfo = pillInfoList.first else { return }
        let timeCount = pillInfo.makeTimeCount()
        
        pillInfoView.titleLabel.text = pillInfo.pillInfo
        pillInfoView.weekLabel.text = pillInfo.termInfo
        pillInfoView.periodLabel.text = pillInfo.periodInfo
        
        setTimeViews(timeCount: timeCount, timeData: pillInfo.timeInfo)
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
