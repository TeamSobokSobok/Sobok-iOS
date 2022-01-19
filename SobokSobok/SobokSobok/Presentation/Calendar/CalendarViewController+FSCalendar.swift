//
//  CalendarViewController+FSCalendar.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/18.
//

import Foundation

import FSCalendar

// MARK: - FSCalendar Delegate

extension CalendarViewController: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeight.constant = bounds.height
        self.view.layoutIfNeeded()
    }
}

// MARK: - FSCalendar DataSource

extension CalendarViewController: FSCalendarDataSource {
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
        
        var filledType = FilledType.none
        var selectedType = SelectedType.not
        var width: CGFloat = 32
        var yPosition: CGFloat = 2
        let formattedDate = date.toString(of: .year)
        
        if self.gregorian.isDateInToday(date) {
            filledType = .today
        } else if doingDates.contains(formattedDate) {
            filledType = .some
        } else if doneDates.contains(formattedDate) {
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

// MARK: - FSCalendar Delegate Appearance

extension CalendarViewController: FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectedDate = date.toString(of: .year)
        dateLabel.text = date.toString(of: .day)
        calendar.select(date)
        
        tabType == .home ?
        getSchedules(date: selectedDate) :
        getFriendSchedules(memberId: memberId, date: selectedDate)
        
        tabType == .home ?
        getPillList(date: selectedDate) :
        getFriendPillList(memberId: memberId, date: selectedDate)
        
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
