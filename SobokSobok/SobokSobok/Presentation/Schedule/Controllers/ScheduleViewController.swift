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
    }
    private let friendNameView = FriendNameView().then {
        $0.friendNameLabel.text = "수현이"
    }
    private let calendarTopView = CalendarTopView().then {
        $0.dateLabel.text = "12월 19일 금요일"
    }
    let calendarView = FSCalendar()
    private lazy var emptyView = ScheduleEmptyView(for: tabCategory)
    var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewLayout()
    )
    var collectionViewHeight: CGFloat = 500.0
    var collectionViewBottomInset: CGFloat = 32.0
    
    // MARK: - Properties
    
    var calendarHeight: CGFloat = 308.0
    var tabCategory: TabBarItem = .home {
        didSet {
            updateUI()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendar()
        setCalendarStyle()
        setDelegation()
        registerCell()
        setCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setCollectionViewHeight()
    }
    
    override func style() {
        emptyView.isHidden = true
        updateUI()
    }
    
    override func hierarchy() {
        view.addSubviews(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubviews(friendNameView, calendarTopView, calendarView, emptyView, collectionView)
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
        
        emptyView.snp.makeConstraints {
            $0.height.equalTo(calendarHeight)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(emptyView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(collectionViewHeight)
        }
    }
    
    private func updateUI() {
        friendNameView.isHidden = tabCategory == .home
    }
}

// MARK: - Setup

extension ScheduleViewController {
    private func setDelegation() {
        scrollView.delegate = self
        calendarView.delegate = self
        calendarTopView.delegate = self
    }
    
    private func setCollectionViewHeight() {
        let newCollectionViewHeight = collectionView.contentSize.height
        if newCollectionViewHeight > 0 && (collectionViewHeight != newCollectionViewHeight) {
            collectionViewHeight = newCollectionViewHeight
            print(collectionViewHeight)
            collectionView.snp.updateConstraints {
                $0.height.equalTo(collectionViewHeight + collectionViewBottomInset)
            }
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
//        scrollView.backgroundColor = scrollView.contentOffset.y > 0 ? Color.gray150 : Color.white
    }
}
