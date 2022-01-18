//
//  MainViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/15.
//

import UIKit

import EasyKit
import FSCalendar

final class CalendarViewController: BaseViewController {
    // MARK: - UI
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var usernameStackView: UIStackView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scopeLabel: UILabel!
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!

    // MARK: - Properties
    /// Data
    var doingDates = [String]()
    var doneDates = [String]()
    var selectedDate: String = Date().toString(of: .day) {
        didSet {
            dateLabel.text = selectedDate
            getSchedules(date: selectedDate)
            getPillList(date: selectedDate)
        }
    }
    
    /// Item
    var scheduleItems: [Schedule] = []
    var pillItems: [PillList] = []
    
    let gregorian = Calendar(identifier: .gregorian)
    private var calendarExpandedState: Bool = false {
        didSet {
            calendarExpandedState ?
            calendar.setScope(.month, animated: true) :
            calendar.setScope(.week, animated: true)
            scopeLabel.text = calendarExpandedState ? "월" : "주"
        }
    }
    var editMode: Bool = false {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var tabType: TabBarItem = .share
    var tabName: String = "수현"
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerXibs()          // 등록 먼저
        setDelegation()
        setCalendar()
        setCalendarStyle()
        setCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        getSchedules(date: Date().toString(of: .year))
        getPillList(date: Date().toString(of: .year))
    }
    
    override func viewDidLayoutSubviews() {
        setCollectionViewHeight()
    }

    override func style() {
        super.style()
        
        usernameStackView.isHidden = tabType == .home
        usernameLabel.setTypoStyle(typoStyle: .header1)
        dateLabel.setTypoStyle(typoStyle: .title2)
        dateLabel.text = Date().toString(of: .day)
        scopeLabel.setTypoStyle(typoStyle: .body7)
    }
    
    @IBAction func scopeButtonTapped(_ sender: Any) {
        calendarExpandedState.toggle()
    }
}

// MARK: - Functions

extension CalendarViewController {
    // MARK: - Set
    
    private func setCalendar() {
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.headerHeight = 0
        calendar.firstWeekday = 2
        calendar.setScope(.week, animated: false)
    }
    
    private func setCalendarStyle() {
        calendar.appearance.weekdayFont = TypoStyle.body7.font
        calendar.appearance.weekdayTextColor = Color.gray600
        calendar.appearance.titleFont = UIFont.font(.pretendardReular, ofSize: 16)
        calendar.appearance.titleDefaultColor = Color.black
        calendar.appearance.titleTodayColor = Color.black
        calendar.appearance.todayColor = .clear
        calendar.placeholderType = .none
    }
    
    private func setCollectionView() {
        collectionView.backgroundColor = Color.gray150

        // FlowLayout
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        let screenSize = UIScreen.main.bounds.width
        let sideMargin = 40 / 375 * screenSize
        flowLayout.estimatedItemSize = CGSize(width: screenSize - sideMargin, height: 500)
        collectionView.collectionViewLayout = flowLayout
        
        self.view.layoutIfNeeded()
    }
    
    private func registerXibs() {
        calendar.register(
            CalendarDayCell.self,
            forCellReuseIdentifier: CalendarDayCell.reuseIdentifier
        )
        collectionView.register(MedicineCollectionViewCell.self)
        collectionView.register(
            TimeHeaderView.nib,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TimeHeaderView.reuseIdentifier
        )
    }
    
    /// 컬렉션뷰 높이 조정 함수
    public func setCollectionViewHeight() {
        collectionViewHeight.constant = collectionView.contentSize.height
    }
    
    private func setDelegation() {
        calendar.delegate = self
        calendar.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        scrollView.delegate = self
    }
    
    // MARK: - Helpers

    public func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "약 수정", style: .default) { _ in }
        let stopAction = UIAlertAction(title: "복약 중단", style: .default) { _ in }
        let deleteAction = UIAlertAction(title: "약 삭제", style: .default) { _ in }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        actionSheet.addAction(editAction, stopAction, deleteAction, cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    public func showStickerBottomSheet() {
        let stickerBottomSheet = StickerBottomSheet.instanceFromNib()
        stickerBottomSheet.modalPresentationStyle = .overCurrentContext
        stickerBottomSheet.modalTransitionStyle = .crossDissolve
        self.tabBarController?.present(stickerBottomSheet, animated: false) {
            stickerBottomSheet.showSheetWithAnimation()
        }
    }
    
    public func getSchedules(date: String) {
        ScheduleAPI.shared.getCalendar(date: date) { [weak self] response in
            switch response {
            case .success(let data):
                guard let data = data as? [Schedule] else { return }
                self?.scheduleItems = data
                self?.parseSchedules()
            default:
                return
            }
        }
    }
    
    private func parseSchedules() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.FormatType.full.description
        let items = scheduleItems.map { [dateFormatter.date(from: $0.scheduleDate) as Any, $0.isComplete] }
        
        for item in items {
            guard let scheduleDate = item[0] as? Date else { return }
            guard let isComplete = item[1] as? String else { return }
            
            if isComplete == "doing" {
                doingDates.append(scheduleDate.toString(of: .year))
            } else if isComplete == "done" {
                doneDates.append(scheduleDate.toString(of: .year))
            }
        }
    }
    
    public func getPillList(date: String) {
        ScheduleAPI.shared.getPillList(date: date) { response in
            switch response {
            case .success(let data):
                guard let data = data as? [PillList] else { return }
                self.pillItems = data
                print(self.pillItems)
            default:
                return
            }
        }
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 2 {
            return UIEdgeInsets(top: 0, left: 10, bottom: 100, right: 10)
        } else {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        }
    }
}

extension CalendarViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.backgroundColor  = scrollView.contentOffset.y > UIScreen.main.bounds.height / 2 ? Color.gray150 : Color.white
    }
}

extension CalendarViewController: PageComponentProtocol {
    var pageTitle: String {
        return tabName
    }
}
