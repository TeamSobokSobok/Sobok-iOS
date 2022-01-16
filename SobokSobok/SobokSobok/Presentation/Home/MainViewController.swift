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
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scopeLabel: UILabel!
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!

    @IBOutlet weak var collectionView: UICollectionView!
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
    fileprivate let kformatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일 EEEE"
        return formatter
    }()
    
    var selectedDate: String = "" {
        didSet {
            dateLabel.text = selectedDate
        }
    }
    
    // 데이터라고 가정
    fileprivate var pillNames: [String] = ["홍삼", "비타민C", "루테인", "혈압약", "알로에", "당뇨약"] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendar()
        setCalendarStyle()
        setCollectionView()
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        setCollectionViewHeight()
    }

    override func style() {
        super.style() // 오버라이딩 위해서는 부모 뷰 상속 필요
        titleLabel.setTypoStyle(typoStyle: .header1)
        dateLabel.setTypoStyle(typoStyle: .title2)
        scopeLabel.setTypoStyle(typoStyle: .body7)
        selectedDate = kformatter.string(from: Date())
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
        calendar.placeholderType = .none
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = Color.gray150
        collectionView.register(MedicineCollectionViewCell.self)
        collectionView.register(TimeHeaderView.nib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TimeHeaderView.reuseIdentifier)
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: collectionView.frame.width - 40, height: 140)
        collectionView.collectionViewLayout = flowLayout
        
        self.view.layoutIfNeeded()
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
        pillNames = pillNames.reversed()
        selectedDate = kformatter.string(from: date)
        
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

// MARK: - CollectionView

extension MainViewController: CollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: MedicineCollectionViewCell.self)
        cell.contentView.backgroundColor = Color.white
        cell.contentView.makeRounded(radius: 12)
        cell.pillName.text = pillNames[indexPath.row % 6]
        if indexPath.row % 2 == 0 {
            cell.stickerStackView.isHidden = true
            cell.stickerCountLabel.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: TimeHeaderView.reuseIdentifier,
                for: indexPath
            ) as? TimeHeaderView else { return UICollectionReusableView() }
            if indexPath.section == 0 {
                headerView.editButtonStackView.isHidden = false
            } else {
                headerView.editButtonStackView.isHidden = true
            }
            return headerView
        default:
            assert(false, "헤더 뷰 찾을 수 없음")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = 77
        return CGSize(width: width, height: height)
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func setCollectionViewHeight() {
        collectionViewHeight.constant = collectionView.contentSize.height
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenWidth = UIScreen.main.bounds.width
//        let width = 335 / 375 * screenWidth
//        let height = width * 140 / 335
//        return CGSize(width: width, height: height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 20, bottom: 32, right: 20)
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.backgroundColor  = scrollView.contentOffset.y > UIScreen.main.bounds.height / 2 ? Color.gray150 : Color.white
    }
}
