//
//  HomeViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/11.
//

import UIKit

final class HomeViewController: BaseViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func style() {
        super.style()
        
        messageLabel.setTypoStyle(typoStyle: .header1)
    }
    
    override func layout() {
        super.layout()
        
        let calendarViewController = CalendarViewController.instanceFromNib()
        calendarViewController.tabType = .home
        embed(calendarViewController, inView: contentView)
    }
}

// MARK: - PageComponentProtocol
extension HomeViewController: PageComponentProtocol {
    var pageTitle: String { "" }
}
