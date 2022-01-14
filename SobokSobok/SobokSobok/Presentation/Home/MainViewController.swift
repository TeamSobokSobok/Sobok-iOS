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
    
    // MARK: - Properties
    
    private var calendarAnimatedState: Bool = false {
        didSet {
            calendarAnimatedState ?
            calendar.setScope(.month, animated: true) :
            calendar.setScope(.week, animated: true)
            
            scopeLabel.text = calendarAnimatedState ? "월" : "주"
        }
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCalendar()
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
    
}
