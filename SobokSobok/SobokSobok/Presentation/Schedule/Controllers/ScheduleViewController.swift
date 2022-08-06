//
//  ScheduleViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/05/18.
//

import UIKit
import FSCalendar

class DynamicHeightCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}

final class ScheduleViewController: BaseViewController {
    
    // MARK: - Properties
    
    let scheduleManager: ScheduleServiceable = ScheduleManager(apiService: APIManager(), environment: .development)
    let stickerManageer: StickerServiceable = StickerManager(apiService: APIManager(), environment: .development)
    
    let gregorian = Calendar(identifier: .gregorian)
    
    var friendName: String? {
        didSet {
            updateUI()
        }
    }
    
    var schedules: [Schedule] = [] {
        didSet {
            parseSchedules()
        }
    }
    var pillLists: [PillList] = [] {
        didSet {
            dataSource.update(with: pillLists)
            collectionView.reloadData()
        }
    }

    var currentDate: Date = Date() {
        didSet {
            callRequestSchedules()
            updateUI()
        }
    }
    var selectedDate = Date().toString(of: .day)
    var doingDates: [String] = []
    var doneDates: [String] = []
    
    var calendarHeight: CGFloat = 308.0
    var collectionViewHeight: CGFloat = 409.0.adjustedHeight
    private var collectionViewBottomInset: CGFloat = 32.0.adjustedHeight
    
    private var scheduleType: ScheduleType
    private lazy var dataSource = ScheduleDataSource(pillSchedules: pillLists, scheduleType: scheduleType)

    
    init(scheduleType: ScheduleType) {
        self.scheduleType = scheduleType
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Properties
    
    lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = Color.gray150
    }
    
    private lazy var stackView = UIStackView().then {
        $0.backgroundColor = .systemBackground
        $0.axis = .vertical
        $0.distribution = .fill
        $0.alignment = .center
    }
    
    private lazy var friendNameView = FriendNameView()
    private let  calendarTopView = CalendarTopView()
    lazy var  calendarView = FSCalendar()
    
    lazy var collectionView = DynamicHeightCollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )
    
    lazy var emptyView = ScheduleEmptyView(for: scheduleType)
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name("sticker"),
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                               name: NSNotification.Name("emotion"),
                                               object: nil)
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDelegation()
        callRequestSchedules()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(stickerTapped),
                                               name: NSNotification.Name("sticker"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(emotionTapped),
                                               name: NSNotification.Name("emotion"),
                                               object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setCollectionViewHeight()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Override Functions
    
    override func style() {
        updateUI()
        setCalendar()
        setCalendarStyle()
        setCollectionView()
        registerCells()
    }
    
    override func hierarchy() {
        view.addSubviews(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(friendNameView, calendarTopView, calendarView, collectionView)
    }
    
    override func layout() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        friendNameView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        calendarTopView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        calendarView.snp.makeConstraints {
            // calendar left, right padding 10씩 조정하기
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(calendarHeight)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(collectionViewHeight)
        }
    }
}

// MARK: - Private Function

extension ScheduleViewController {
    @objc func stickerTapped(notification: NSNotification) {
        if let notification = notification.userInfo,
           let scheduleId = notification["scheduleId"] as? Int {
            getStickers(for: scheduleId)
        }
    }
    
    @objc func emotionTapped(notification: NSNotification) {
        
    }
    
    private func callRequestSchedules() {
        switch scheduleType {
        case .main:
            getMySchedules(date: currentDate.toString(of: .year))
            getMyPillLists(date: currentDate.toString(of: .year))
        case .share:
            getMemberSchedules(memberId: 187, date: currentDate.toString(of: .year))
            getMemberPillLists(memberId: 187, date: currentDate.toString(of: .year))
        }
    }
    
    private func updateUI() {
        friendNameView.isHidden = friendName == nil ? true : false
        friendNameView.friendNameLabel.text = friendName
        calendarTopView.dateLabel.text = currentDate.toString(of: .day)
    }
    
    private func setDelegation() {
        scrollView.delegate = self
        calendarView.delegate = self
        calendarView.dataSource = self
        calendarTopView.delegate = self
        collectionView.dataSource = dataSource
    }
    
    // TODO: - 높이 문제 해결 필요
    
    func setCollectionViewHeight() {
        var newCollectionViewHeight = pillLists.isEmpty ? 409.0 : collectionView.contentSize.height
        newCollectionViewHeight = newCollectionViewHeight < 409.0 ? 409.0 : newCollectionViewHeight
        if newCollectionViewHeight > 0 {
            collectionViewHeight = newCollectionViewHeight
            collectionView.snp.updateConstraints {
                $0.height.equalTo(collectionViewHeight + collectionViewBottomInset)
            }
        }
    }
    
    func registerCells() {
        calendarView.register(
            CalendarDayCell.self,
            forCellReuseIdentifier: CalendarDayCell.reuseIdentifier
        )
        
        collectionView.register(
            MainScheduleCell.self,
            forCellWithReuseIdentifier: MainScheduleCell.reuseIdentifier
        )
        
        collectionView.register(
            ShareScheduleCell.self,
            forCellWithReuseIdentifier: ShareScheduleCell.reuseIdentifier
        )
        
        collectionView.register(
            ScheduleHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: ScheduleHeaderView.reuseIdentifier
        )
    }
    
    func setCollectionView() {
        collectionView.backgroundColor = Color.gray150
        collectionView.collectionViewLayout = generateLayout()
    }
    
    func parseSchedules() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.FormatType.full.description

        let doneItems = schedules
            .filter { $0.isComplete == "done" }
            .map { dateFormatter.date(from: $0.scheduleDate)!.toString(of: .year) }
        let doingItems = schedules
            .filter { $0.isComplete == "doing" }
            .map { dateFormatter.date(from: $0.scheduleDate)!.toString(of: .year) }
        
        self.doneDates = doneItems
        self.doingDates = doingItems
        
        calendarView.reloadData()
    }
    
    func showStickerBottomSheet(stickers: [Stickers]?) {
        let stickerBottomSheet = StickerBottomSheet.instanceFromNib()
        stickerBottomSheet.modalPresentationStyle = .overCurrentContext
        stickerBottomSheet.modalTransitionStyle = .crossDissolve
        stickerBottomSheet.stickers = stickers
        self.tabBarController?.present(stickerBottomSheet, animated: false) {
            stickerBottomSheet.showSheetWithAnimation()
        }
    }
}

extension ScheduleViewController: CalendarTopViewDelegate {
    func calendarTopView(scope: CalendarScopeState) {
        calendarView.setScope(scope == .week ? .week : .month, animated: true)
        calendarTopView.scopeButton.setTitle(scope == .week ? "주" : "월", for: .normal)
        calendarTopView.scopeButton.setImage(scope == .week ? Image.icArrowDropDown16 : Image.icArrowUp16, for: .normal)
    }
}

extension ScheduleViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y > 0
        scrollView.backgroundColor = scrollView.contentOffset.y > 0 ? Color.gray150 : Color.white
    }
}
