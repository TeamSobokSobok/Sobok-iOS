//
//  ShareViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/12.
//

import UIKit

final class ShareViewController: BaseViewController {

    @IBOutlet weak var pagerTab: PagerTab!
    
    let calendarViewController = CalendarViewController.instanceFromNib()
    var viewControllers: [PageComponentProtocol] = []
    var groupItems = [Member]() {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGroupInfo()
        
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)      
      
        tabBarController?.tabBar.isHidden = false
        calendarViewController.getSchedules(date: Date().toString(of: .year))
    }
}

extension ShareViewController {
    private func getGroupInfo() {
        ShareAPI.shared.getGroupInfo { response in
            switch response {
            case .success(let data):
                if let data = data as? [Member] {
                    self.groupItems = data
                }
                self.setContainerViewController(groupItems: self.groupItems)
            default:
                return
            }
        }
    }
    
    private func setContainerViewController(groupItems: [Member]) {
        for index in 0 ..< groupItems.count {
            let calendarViewController = CalendarViewController.instanceFromNib()
            calendarViewController.tabName = groupItems[index].memberName
            calendarViewController.memberId = groupItems[index].memberId
            viewControllers.append(calendarViewController)
        }
        
        let style = PagerTab.Style.default
        pagerTab.setup(self, viewControllers: viewControllers, style: style)
    }
}
