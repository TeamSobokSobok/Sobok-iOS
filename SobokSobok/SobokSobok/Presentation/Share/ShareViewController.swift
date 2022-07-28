//
//  ShareViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/12.
//

import UIKit

final class ShareViewController: BaseViewController {
    var members: [Member] = [
        Member(groupId: 12, memberId: 12, memberName: "TAB"),
        Member(groupId: 12, memberId: 12, memberName: "TAB"),
        Member(groupId: 12, memberId: 12, memberName: "TAB"),
    ]
    
    private lazy var shareTopView = ShareTopView()
    private let scheduleViewController = ScheduleViewController()
    private lazy var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGroupInfo()
        
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
    }
}

extension ShareViewController: PagerTabDelegate {
    func addFriendDeleagte() {
        let viewController = SearchNicknameViewController.instanceFromNib()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ShareViewController {
    private func getGroupInfo() {
        ShareAPI.shared.getGroupInfo { response in
            switch response {
            case .success(let data):
                if let data = data as? [Member] {
                    self.members = data
                }
            default:
                return
            }
        }
    }
}
