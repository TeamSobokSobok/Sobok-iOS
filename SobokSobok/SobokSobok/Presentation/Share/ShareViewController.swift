//
//  ShareViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/12.
//

import UIKit

final class ShareViewController: BaseViewController {

    @IBOutlet weak var pagerTab: PagerTab!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewControllers: [PageComponentProtocol] = [
            CalendarViewController.instanceFromNib(),
            CalendarViewController.instanceFromNib(),
            CalendarViewController.instanceFromNib(),
            CalendarViewController.instanceFromNib(),
            CalendarViewController.instanceFromNib()
        ]
        let style = PagerTab.Style.default
        pagerTab.setup(self, viewControllers: viewControllers, style: style)
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)      
      
        tabBarController?.tabBar.isHidden = false
    }
}
