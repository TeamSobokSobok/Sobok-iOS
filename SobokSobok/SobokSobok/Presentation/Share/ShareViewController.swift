//
//  ShareViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/12.
//

import UIKit

final class ShareViewController: BaseViewController {
    var members: [Member] = UserDefaults.standard.member {
        didSet {
            initialAttributes()
        }
    }
    lazy var scheduleManager: ScheduleServiceable = ScheduleManager(apiService: APIManager(),
                                                                    environment: .development)
    
    lazy var shareTopView = ShareTopView()
    let scheduleViewController = ScheduleViewController(scheduleType: .share)
    private lazy var containerView = UIView()
    private lazy var emptyView = ShareEmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addFriend()
    }
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getGroupInformation()
    }
    
    override func style() {
        initialAttributes()
    }
    
    override func layout() {
        super.layout()
       
        
        view.addSubviews(shareTopView, containerView, emptyView)
        embed(scheduleViewController, inView: containerView)
        
        shareTopView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(123.adjustedHeight)
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(shareTopView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(shareTopView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
}

extension ShareViewController {
    
    func initialAttributes() {
        scheduleViewController.calendarTopView.isHidden = members.isEmpty
        scheduleViewController.calendarView.isHidden = members.isEmpty
        containerView.isHidden = members.isEmpty
        emptyView.isHidden = !members.isEmpty
        emptyView.addButton.addTarget(self, action: #selector(transitionToSearchNicknameViewController), for: .touchUpInside)
        shareTopView.members = members
        scheduleViewController.member = members
    }
    
    @objc func addFriend() {
        shareTopView.completion = {
            self.transitionToSearchNicknameViewController()
        }
    }
}

extension ShareViewController {
    
    @objc func transitionToSearchNicknameViewController() {
        let searchNicknameViewController = UINavigationController(rootViewController: SearchNicknameViewController.instanceFromNib())
        searchNicknameViewController.modalPresentationStyle = .fullScreen
        self.present(searchNicknameViewController, animated: true)
    }
}
