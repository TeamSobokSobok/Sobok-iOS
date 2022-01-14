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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func style() {
        titleLabel.setTypoStyle(typoStyle: .header1)
    }
    
    @IBAction func scopeButtonTapped(_ sender: Any) {
    }
}
