//
//  HomeViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/11.
//

import UIKit

final class HomeViewController: BaseViewController, PageComponentProtocol {
    var pageTitle: String {
        "수현"
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func layout() {
        super.layout()
        let calendarViewController = CalendarViewController.instanceFromNib()
        calendarViewController.tabType = .home
        contentView.addSubview(calendarViewController.view)
    }
    
    override func style() {
        super.style()
        
        messageLabel.setTypoStyle(typoStyle: .header1)
    }
}
