//
//  CalendarView.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/08.
//

import UIKit

import FSCalendar

final class CalendarView: BaseView, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    // MARK: - UIComponents
    
    lazy var dateLabel = UILabel().then {
        $0.font = UIFont.font(.pretendardSemibold, ofSize: 18)
    }
    lazy var previousButton = UIButton().then {
        $0.setImage(Image.icNextSmall48, for: .normal)
        $0.imageView?.transform = ($0.imageView?.transform.rotated(by: .pi))!
    }
    lazy var nextButton = UIButton().then {
        $0.setImage(Image.icNextSmall48, for: .normal)
    }
    lazy var checkButton = UIButton().then {
        $0.setImage(Image.icChecked, for: .normal)
        $0.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
    }
    lazy var threeMonthLabel = UILabel().then {
        $0.text = "시작일로부터 3개월"
        $0.font = UIFont.font(.pretendardRegular, ofSize: 16)
    }
    lazy var messageLabel = UILabel().then {
        $0.text = "최대 3개월까지 복약 기간을 설정할 수 있어요"
        $0.textColor = Color.gray500
        $0.font = UIFont.font(.pretendardMedium, ofSize: 15)
    }
    
    
    // MARK: - Properties

    private var isCheckedThreeMonthState: Bool = true
    
    
    // MARK: - Date Properties
    
    private lazy var calendar = FSCalendar()
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    private var currentDate = Date()
    private var firstDate: Date?
    private var lastDate: Date?
    private var datesRange: [Date]?

    override func setupView() {
        addSubviews(previousButton, nextButton, dateLabel, calendar, checkButton, threeMonthLabel, messageLabel)
        setCalendar()
    }
    
    override func setupConstraints() {
        calendar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(253)
        }
        
        dateLabel.snp.makeConstraints {
            $0.bottom.equalTo(calendar.snp.top).offset(-17)
            $0.centerX.equalToSuperview()
        }
        
        previousButton.snp.makeConstraints {
            $0.leading.equalTo(calendar.snp.leading)
            $0.centerY.equalTo(dateLabel)
        }
        
        nextButton.snp.makeConstraints {
            $0.trailing.equalTo(calendar.snp.trailing)
            $0.centerY.equalTo(dateLabel)
        }
        
        checkButton.snp.makeConstraints {
            $0.top.equalTo(calendar.snp.bottom)
            $0.leading.equalTo(calendar.snp.leading)
            $0.width.height.equalTo(40)
        }
        
        threeMonthLabel.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing)
            $0.centerY.equalTo(checkButton.snp.centerY)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(checkButton.snp.bottom)
            $0.leading.equalToSuperview().inset(14)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rectShape = CAShapeLayer()
        rectShape.bounds = calendar.frame
        rectShape.position = calendar.center
        rectShape.path = UIBezierPath(roundedRect: calendar.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 30, height: 30)).cgPath
        calendar.layer.mask = rectShape
    }
}

// MARK: - Objc Functions

extension CalendarView {
    
    @objc func checkButtonTapped(_ sender: UIButton) {
        if isCheckedThreeMonthState {
            // uncheck
            checkButton.setImage(Image.icCheckedNot, for: .normal)
            self.clearSelectedDates()
            
        } else {
            // check
            checkButton.setImage(Image.icChecked, for: .normal)
            self.makeRangesToThreeMonth()
        }
        
        isCheckedThreeMonthState.toggle()
    }
}

// MARK:- FSCalendarDataSource

extension CalendarView {
    
    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {
        let cell = calendar.dequeueReusableCell(withIdentifier: "cell", for: date, at: position)
        return cell
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        self.configure(cell: cell, for: date, at: position)
    }
}


// MARK:- FSCalendarDelegate

extension CalendarView {
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition)   -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, shouldDeselect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return monthPosition == .current
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        /// nothing selected:
        if firstDate == nil {
            firstDate = date
            datesRange = [date]
            self.configureVisibleCells()
            return
        }

        /// only first date is selected:
        if let first = firstDate, lastDate == nil {
            if date <= first {
                calendar.deselect(first)
                firstDate = date
                datesRange = [first]

                self.configureVisibleCells()
                return
            }

            let range = datesRange(from: first, to: date)
            lastDate = range.last
            for d in range {
                calendar.select(d)
            }
            datesRange = range
            self.configureVisibleCells()
            return
        }

        // both are selected:
        if firstDate != nil && lastDate != nil {
            self.clearSelectedDates()
        }
    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.clearSelectedDates()
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        currentDate = calendar.currentPage
        dateLabel.text = currentDate.toString(of: .calendarWithMonth)
    }
}


// MARK: - Configure functions

extension CalendarView {
    
    private func configureVisibleCells() {
        calendar.visibleCells().forEach { (cell) in
            let date = calendar.date(for: cell)
            let position = calendar.monthPosition(for: cell)
            self.configure(cell: cell, for: date!, at: position)
        }
    }
    
    private func configure(cell: FSCalendarCell, for date: Date, at position: FSCalendarMonthPosition) {
        let diyCell = (cell as! DIYCalendarCell)
        if position == .current {
            var selectionType = SelectionType.none
            if calendar.selectedDates.contains(date) {
                let previousDate = self.gregorian.date(byAdding: .day, value: -1, to: date)!
                let nextDate = self.gregorian.date(byAdding: .day, value: 1, to: date)!
                if calendar.selectedDates.contains(date) {
                    if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(nextDate) {
                        if getWeekday(date: date) == "월" {
                            selectionType = .leftBorder
                            diyCell.titleLabel.textColor = .black
                        } else if getWeekday(date: date) == "일" {
                            selectionType = .rightBorder
                        } else {
                            selectionType = .middle
                        }
                        diyCell.titleLabel.textColor = .black
                    }
                    else if calendar.selectedDates.contains(previousDate) && calendar.selectedDates.contains(date) {
                        selectionType = .rightBorder
                        diyCell.titleLabel.textColor = UIColor(red: 0 / 255, green: 171 / 255, blue: 182 / 255, alpha: 1.0)
                    }
                    else if calendar.selectedDates.contains(nextDate) {
                        selectionType = .leftBorder
                        diyCell.titleLabel.textColor = UIColor(red: 0 / 255, green: 171 / 255, blue: 182 / 255, alpha: 1.0)
                    }
                    else {
                        selectionType = .single
                    }
                }
            }
            else {
                selectionType = .none
            }
            diyCell.selectionType = selectionType
        } else {
            diyCell.selectionType = .none
        }
    }
}


// MARK: - Private Functions

extension CalendarView {
    
    private func setCalendar() {
        dateLabel.text = currentDate.toString(of: .calendarWithMonth)
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.headerHeight = 0
        calendar.allowsMultipleSelection = true
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.placeholderType = .none
        calendar.firstWeekday = 2
        
        // header - 3월 2022 이 부분 의미
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 13, weight: .semibold)
        calendar.appearance.weekdayTextColor = UIColor(red: 132/255, green: 140/255, blue: 146/255, alpha: 1.0)
        calendar.appearance.titleFont = UIFont.systemFont(ofSize: 18)
        
        calendar.weekdayHeight = 22
        calendar.rowHeight = 58
        
        calendar.today = nil
        calendar.register(DIYCalendarCell.self, forCellReuseIdentifier: "cell")
        
        self.makeRangesToThreeMonth()
    }
    
    // 양 사이드에 날짜가 있을시 둥글게 표현해주기 위함.
    private func getWeekday(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko")
        dateFormatter.dateFormat = "E"
        let date_string = dateFormatter.string(from: date)
        return date_string
    }
    
    func datesRange(from: Date, to: Date) -> [Date] {
        if from > to { return [Date]() }
        var tempDate = from
        var array = [tempDate]
        while tempDate < to {
            if let date = Calendar.current.date(byAdding: .day, value: 1, to: tempDate) {
                tempDate = date
                array.append(tempDate)
            }
        }
        return array
    }
    
    // 선택된 날짜 클리어
    private func clearSelectedDates() {
        for d in calendar.selectedDates {
            calendar.deselect(d)
        }
        lastDate = nil
        firstDate = nil
        datesRange = []
        configureVisibleCells()
    }
    
    // 날짜 3개월치 선택하기
    private func makeRangesToThreeMonth() {
        if firstDate == nil {
            firstDate = Date()
        }
        let lastDate = Calendar.current.date(byAdding: .month, value: 3, to: firstDate!)
        let range = datesRange(from: firstDate!, to: lastDate!)
        self.lastDate = range.last
        
        for d in range {
            calendar.select(d)
        }
        datesRange = range
        self.configureVisibleCells()
        
        calendar.setCurrentPage(firstDate!, animated: true)
    }
}
