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
    
    lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )

    // MARK: - Properties
    
    var currentDate: Date = Date() {
        didSet {
            updateUI()
        }
    }
    
    var calendarHeight: CGFloat = 308.0
    var collectionViewHeight: CGFloat = 500.0
    private var collectionViewBottomInset: CGFloat = 32.0
    var friendName: String? {
        didSet {
            updateUI()
        }
    }
    
    let gregorian = Calendar(identifier: .gregorian)
    var doingDates: [String] = [] {
        didSet {
            print("change")
            calendarView.reloadData()
        }
    }
    var doneDates: [String] = [] {
        didSet {
            print("change")
            calendarView.reloadData()
        }
    }
    var selectedDate: String = Date().toString(of: .day)
    var pillItems: [PillList] = [] {
        didSet {
            print("약 채워졌다~")
            collectionView.reloadData()
            setCollectionViewHeight()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendar()
        setCalendarStyle()
        setDelegation()
        registerCells()
        setCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCollectionViewHeight()
    }
    
    override func style() {
        updateUI()
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
        collectionView.dataSource = self
    }
    
    private func setCollectionViewHeight() {
        let newCollectionViewHeight = collectionView.contentSize.height
        if newCollectionViewHeight > 0 && (collectionViewHeight != newCollectionViewHeight) {
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
            ScheduleCell.self,
            forCellWithReuseIdentifier: ScheduleCell.reuseIdentifier
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
