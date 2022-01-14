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
    
    @IBOutlet weak var calendar: FSCalendar! {
        didSet {
            calendar.delegate = self
            calendar.dataSource = self
        }
    }
    @IBOutlet weak var calendarHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func style() {
        titleLabel.setTypoStyle(typoStyle: .header1)
    }
    
    @IBAction func scopeButtonTapped(_ sender: Any) {
    }
}

// MARK: - FSCalendar

extension MainViewController: FSCalendarDelegate {}

extension MainViewController: FSCalendarDataSource {
    
}
