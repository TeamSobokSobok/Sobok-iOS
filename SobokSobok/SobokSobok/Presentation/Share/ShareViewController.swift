//
//  ShareViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/12.
//

import UIKit

final class ShareViewController: BaseViewController {
    var members: [Member] = []
    lazy var scheduleManager: ScheduleServiceable = ScheduleManager(apiService: APIManager(),
                                                                    environment: .development)
    
    lazy var shareTopView = ShareTopView()
    private let scheduleViewController = ScheduleViewController(type: .share)
    private lazy var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubviews(shareTopView, containerView)
        embed(scheduleViewController, inView: containerView)
        
        shareTopView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(123.adjustedHeight)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(shareTopView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }

        scheduleViewController.friendName = "태현"
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)      

        tabBarController?.tabBar.isHidden = false
        getGroupInformation()
    }
}
