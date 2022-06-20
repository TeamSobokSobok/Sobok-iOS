//
//  ScheduleViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/05/18.
//

import UIKit
import FSCalendar

final class ScheduleViewController: BaseViewController {

    // MARK: - UI Properties
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    private lazy var stackView = UIStackView().then {
        $0.axis = .vertical
    }
    private let friendNameView = FriendNameView().then {
        $0.friendNameLabel.text = "수현이"
    }
    private let calendarTopView = CalendarTopView().then {
        $0.dateLabel.text = "12월 19일 금요일"
    }
    private let calendarView = FSCalendar()
    
    // MARK: - Properties
    
    private var calendarHeight: CGFloat = 308.0
    enum TabCategory {
        case home, share
    }
    var tabCategory: TabCategory = .share {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendar()
        setCalendarStyle()
        setDelegation()
    }
    
    override func style() {
        view.backgroundColor = .systemBackground
        updateUI()
    }
    
    override func hierarchy() {
        view.addSubviews(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(friendNameView, calendarTopView, calendarView)
    }
    
    override func layout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        calendarView.snp.makeConstraints {
            $0.height.equalTo(calendarHeight)
        }
    }
    
    private func updateUI() {
        friendNameView.isHidden = tabCategory == .home
    }
}

// MARK: - Setup

extension ScheduleViewController {
    private func setCalendar() {
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.headerHeight = 0
        calendarView.firstWeekday = 2
        calendarView.setScope(.week, animated: false)
    }
    
    private func setCalendarStyle() {
        calendarView.appearance.weekdayFont = TypoStyle.body7.font
        calendarView.appearance.weekdayTextColor = Color.gray600
        calendarView.appearance.titleFont = UIFont.font(.pretendardRegular, ofSize: 16)
        calendarView.appearance.titleDefaultColor = Color.black
        calendarView.appearance.titleTodayColor = Color.black
        calendarView.appearance.todayColor = .clear
        calendarView.placeholderType = .none
    }
    
    private func setDelegation() {
        calendarView.delegate = self
        calendarTopView.delegate = self
    }
}

extension ScheduleViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeight = bounds.height
        calendarView.snp.remakeConstraints {
            $0.height.equalTo(calendarHeight)
        }
        self.scrollView.layoutIfNeeded()
    }
}

extension ScheduleViewController: CalendarTopViewDelegate {
    func calendarTopView(scope: CalendarScopeState) {
        calendarView.setScope(scope == .week ? .week : .month, animated: true)
        calendarTopView.scopeButton.setTitle(scope == .week ? "주" : "월", for: .normal)
        calendarTopView.scopeButton.setImage(scope == .week ? Image.icArrowDropDown16 : Image.icArrowUp16, for: .normal)
    }
}
