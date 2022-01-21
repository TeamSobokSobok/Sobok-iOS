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
    @IBOutlet weak var usernameLabel: UILabel! {
        didSet {
            usernameLabel.text = tabName
        }
    }
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var scopeLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var emptyImageView: UIImageView!
    @IBOutlet weak var emptyViewHeight: NSLayoutConstraint!
    
    // MARK: - Properties

    var doingDates = [String]()
    var doneDates = [String]()
    var selectedDate: String = Date().toString(of: .day) {
        didSet {
            dateLabel.text = selectedDate
        }
    }
    var scheduleItems: [Schedule] = []
    var pillItems: [PillList] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    var stickerItems: [Stickers] = []
    var stickerCounts: [Int: Int] = [:] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let gregorian = Calendar(identifier: .gregorian)
    private var calendarExpandedState: Bool = false {
        didSet {
            calendarExpandedState ?
            calendar.setScope(.month, animated: true) :
            calendar.setScope(.week, animated: true)
            scopeLabel.text = calendarExpandedState ? "월" : "주"
            arrowImageView.image = calendarExpandedState ? Image.icArrowUp16 : Image.icArrowDropDown16
        }
    }
    var editMode: Bool = false {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var emotionState: Bool = false {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var tabType: TabBarItem = .share
    var tabName: String = "수현"
    var memberId: Int = 0
    var groupId: Int = 0
    
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
        emptyImageView.image = tabType == .home ? Image.illustNoPill : Image.illustNoShare
    }
    
    @IBAction func scopeButtonTapped(_ sender: Any) {
        calendarExpandedState.toggle()
    }
}

// MARK: - Set Functions

extension CalendarViewController {
    private func setCalendar() {
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.headerHeight = 0
        calendar.firstWeekday = 2
        calendar.setScope(.week, animated: false)
    }
    
    private func setCalendarStyle() {
        calendar.appearance.weekdayFont = TypoStyle.body7.font
        calendar.appearance.weekdayTextColor = Color.gray600
        calendar.appearance.titleFont = UIFont.font(.pretendardRegular, ofSize: 16)
        calendar.appearance.titleDefaultColor = Color.black
        calendar.appearance.titleTodayColor = Color.black
        calendar.appearance.todayColor = .clear
        calendar.placeholderType = .none
    }
    
    private func setCollectionView() {
        collectionView.backgroundColor = Color.gray150
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 8
        let screenSize = UIScreen.main.bounds.width
        let sideMargin = 40 / 375 * screenSize
        flowLayout.estimatedItemSize = CGSize(width: screenSize - sideMargin, height: 140)
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
}

// MARK: - Helpers

extension CalendarViewController {
    public func showActionSheet(pillId: Int, date: String) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "약 수정", style: .default) { _ in }
        let stopAction = UIAlertAction(title: "복약 중단", style: .default) { _ in
            self.showAlert(title: "정말로 복약을 중단하나요?",
                           message: "복약을 중단하면 내일부터 약 알림이 오지 않아요",
                           completionTitle: "복약 중단",
                           cancelTitle: "취소") { _ in
                self.stopPillList(pillId: pillId, day: date)
                self.getPillList(date: self.selectedDate)
                self.collectionView.reloadData()
                self.view.layoutSubviews()
            }
        }
        let deleteAction = UIAlertAction(title: "약 삭제", style: .default) { _ in
            self.showAlert(title: "정말로 약을 삭제하나요?",
                           message: "해당 약에 대한 전체 복약 기록이 사라지고 알림도 오지 않아요",
                           completionTitle: "삭제",
                           cancelTitle: "취소") { _ in
                self.deletePillList(pillId: pillId)
                self.getPillList(date: self.selectedDate)
                self.collectionView.reloadData()
                self.view.layoutSubviews()
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        actionSheet.addAction(editAction, stopAction, deleteAction, cancelAction)
        present(actionSheet, animated: true, completion: nil)
    }
    
    public func showStickerBottomSheet(stickers: [Stickers]) {
        let stickerBottomSheet = StickerBottomSheet.instanceFromNib()
        stickerBottomSheet.modalPresentationStyle = .overCurrentContext
        stickerBottomSheet.modalTransitionStyle = .crossDissolve
        stickerBottomSheet.stickers = stickers
        self.tabBarController?.present(stickerBottomSheet, animated: false) {
            stickerBottomSheet.showSheetWithAnimation()
        }
    }
}

// MARK: - PageComponentProtocol

extension CalendarViewController: PageComponentProtocol {
    var pageTitle: String {
        return "\(tabName.prefix(2))"
    }
}
