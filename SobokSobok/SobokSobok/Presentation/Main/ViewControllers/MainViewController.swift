//
//  MainViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/11.
//

import UIKit

import SnapKit

final class MainViewController: BaseViewController {

    private let homeTopView = HomeTopView()
    private let scheduleViewController = ScheduleViewController()
    private let containerView = UIView()
    
    let scheduleManager: ScheduleServiceable = ScheduleManager(apiService: APIManager(),
                                                               environment: .mock)
    var schedules: [Schedule] = [] {
        didSet {
            parseSchedules()
        }
    }
    
    var pillLists: [PillList] = [] {
        didSet {
            scheduleViewController.pillItems = pillLists
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getMySchedules(date: "2022-06-30")
        getMyPillLists(date: "2022-06-22")
    }

    override func style() {
        super.style()
        
        homeTopView.mainMessageLabel.text = "소중한 태끼님\n오늘도 약 꼭 챙겨 드세요"
        containerView.backgroundColor = .red
    }
    
    override func hierarchy() {
        view.addSubviews(homeTopView, containerView)
        embed(scheduleViewController, inView: containerView)
    }
    
    override func layout() {
        homeTopView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(28.adjustedHeight)
            $0.leading.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(homeTopView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
}

extension MainViewController {
    func parseSchedules() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.FormatType.full.description

        let doneItems = schedules
            .filter { $0.isComplete == "done" }
            .map { dateFormatter.date(from: $0.scheduleDate)!.toString(of: .year) }
        let doingItems = schedules
            .filter { $0.isComplete == "doing" }
            .map { dateFormatter.date(from: $0.scheduleDate)!.toString(of: .year) }
        
        scheduleViewController.doneDates = doneItems
        scheduleViewController.doingDates = doingItems
    }
}
