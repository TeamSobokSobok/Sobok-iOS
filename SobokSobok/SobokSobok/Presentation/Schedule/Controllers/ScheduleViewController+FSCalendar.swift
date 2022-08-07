//
//  ScheduleViewController+FSCalendar.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/22.
//

// MARK: - FSCalendar Setup

import FSCalendar
import Foundation

extension ScheduleViewController {
    func setCalendar() {
        calendarView.locale = Locale(identifier: "ko_KR")
        calendarView.headerHeight = 0
        calendarView.firstWeekday = 2
        calendarView.setScope(.week, animated: false)
    }
    
    func setCalendarStyle() {
        calendarView.appearance.weekdayFont = TypoStyle.body7.font
        calendarView.appearance.weekdayTextColor = Color.gray600
        calendarView.appearance.titleFont = UIFont.font(.pretendardRegular, ofSize: 16)
        calendarView.appearance.titleDefaultColor = Color.black
        calendarView.appearance.titleTodayColor = Color.black
        calendarView.appearance.todayColor = .clear
        calendarView.placeholderType = .none
    }
}

// MARK: - FSCalendar Delegate

extension ScheduleViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeight = bounds.height
        calendarView.snp.updateConstraints {
            $0.height.equalTo(calendarHeight)
        }
        self.scrollView.layoutIfNeeded()
    }
}

// MARK: - FSCalendar DataSource

extension ScheduleViewController: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        guard let cell = calendar.dequeueReusableCell(
            withIdentifier: CalendarDayCell.reuseIdentifier,
            for: date,
            at: position
        ) as? CalendarDayCell else { return FSCalendarCell() }
        configure(cell: cell, for: date, at: position)
        return cell
    }

    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        guard let cell = cell as? CalendarDayCell else { return }
        let filledType = checkDate(for: date)
        checkSeletedDates(cell, for: date, typeFor: filledType)
    }
    
    private func checkDate(for date: Date) -> FilledType {
        let formattedDate = date.toString(of: .year)
        
        if self.gregorian.isDateInToday(date) {
            return .today
        } else if doingDates.contains(formattedDate) {
            return .some
        } else if doneDates.contains(formattedDate) {
            return .all
        } else {
            return .none
        }
    }
    
    private func checkSeletedDates(_ cell: CalendarDayCell, for date: Date, typeFor filledType: FilledType) {
        let isSelected = calendarView.selectedDates.contains(date)
        cell.configureUI(isSelected: isSelected, with: filledType)
    }
}

// MARK: - FSCalendar Delegate Appearance

extension ScheduleViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.currentDate = date
        self.configureVisibleCells()
    }
    
    private func configureVisibleCells() {
        calendarView.visibleCells().forEach { (cell) in
            let date = calendarView.date(for: cell)
            let position = calendarView.monthPosition(for: cell)
            self.configure(cell: cell, for: date!, at: position)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        // currentMonth 비교해서 바뀌었을 때만 서버 통신
        currentDate = calendar.currentPage
        calendar.select(calendar.currentPage)
        calendar.reloadData() // UI 업데이트 안 되는 이슈 있어서 reload
    }
}
