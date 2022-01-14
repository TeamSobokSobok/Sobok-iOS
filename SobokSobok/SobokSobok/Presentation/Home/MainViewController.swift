//
//  MainViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/15.
//

import UIKit

import FSCalendar

final class MainViewController: BaseViewController {

    // MARK: - UI
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scopeLabel: UILabel!
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UIView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    let someDates = ["2022-01-09", "2022-01-22", "2022-01-30"]
    let allDates = ["2022-01-12", "2022-01-15", "2022-01-17"]
    
    // MARK: - Properties
    
    private var calendarAnimatedState: Bool = false {
        didSet {
            calendarAnimatedState ?
            calendar.setScope(.month, animated: true) :
            calendar.setScope(.week, animated: true)
            
            scopeLabel.text = calendarAnimatedState ? "월" : "주"
        }
    }
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendar()
        setCalendarStyle()
    }

    override func style() {
        super.style() // 오버라이딩 위해서는 부모 뷰 상속 필요
        titleLabel.setTypoStyle(typoStyle: .header1)
        dateLabel.setTypoStyle(typoStyle: .title2)
        scopeLabel.setTypoStyle(typoStyle: .body7)
    }
    
    // MARK: - Functions
    
    private func setCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.headerHeight = 0
        calendar.setScope(.week, animated: false)
        calendar.register(CalendarDayCell.self, forCellReuseIdentifier: CalendarDayCell.reuseIdentifier)
    }
    
    private func setCalendarStyle() {
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.firstWeekday = 2
        calendar.appearance.weekdayFont = TypoStyle.body7.font
        calendar.appearance.weekdayTextColor = Color.gray600
        calendar.appearance.titleFont = UIFont.font(.pretendardReular, ofSize: 16)
        calendar.appearance.titleDefaultColor = Color.black
        calendar.appearance.titleTodayColor = Color.black
        calendar.appearance.todayColor = .clear
    }
    
    @IBAction func scopeButtonTapped(_ sender: Any) {
        calendarAnimatedState.toggle()
    }
}

// MARK: - FSCalendar

extension MainViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeight.constant = bounds.height
        self.view.layoutIfNeeded()
    }

}

extension MainViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        guard let cell = calendar.dequeueReusableCell(
            withIdentifier: CalendarDayCell.reuseIdentifier,
            for: date,
            at: position
        ) as? CalendarDayCell else { return FSCalendarCell() }
        configure(cell: cell, for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {

    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        guard let cell = cell as? CalendarDayCell else { return }
        
        var filledType = FilledType.none
        var selectedType = SelectedType.not
        var width: CGFloat = 32
        var yPosition: CGFloat = 2
        let formattedDate = formatter.string(from: date)
        
        if self.gregorian.isDateInToday(date) {
            filledType = .today
        } else if someDates.contains(formattedDate) {
            filledType = .some
        } else if allDates.contains(formattedDate) {
            filledType = .all
        } else {
            filledType = .none
        }
        
        if calendar.selectedDates.contains(date) && !gregorian.isDateInToday(date) {
            width = 44
            yPosition = -4
            selectedType = .single
        }
        
        cell.width = width
        cell.yPosition = yPosition
        cell.selectedType = selectedType
        cell.filledType = filledType
    }
}

extension MainViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        calendar.select(date)
        self.configureVisibleCells()
    }
    
    private func configureVisibleCells() {
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date!, at: position)
        }
    }
}
