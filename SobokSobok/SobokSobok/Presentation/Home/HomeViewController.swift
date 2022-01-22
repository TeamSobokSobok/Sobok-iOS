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
    
    let calendarViewController = CalendarViewController.instanceFromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarViewController.getSchedules(date: Date().toString(of: .year))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        calendarViewController.getSchedules(date: Date().toString(of: .year))
    }

    override func style() {
        super.style()
        
        messageLabel.setTypoStyle(typoStyle: .header1)
    }
    
    override func layout() {
        super.layout()
        
        calendarViewController.tabType = .home
        embed(calendarViewController, inView: contentView)
    }
}

// MARK: - PageComponentProtocol
extension HomeViewController: PageComponentProtocol {
    func addFriendDeleagte() {
        return
    }
    
    var pageTitle: String { "" }
}
