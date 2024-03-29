//
//  MainViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/11.
//

import UIKit

import SnapKit

final class MainViewController: BaseViewController {

    private let homeTopView = HomeTopView()
    private let scheduleViewController = ScheduleViewController(scheduleType: .main)
    private let containerView = UIView()
    
    var userName: String = UserDefaultsManager.userName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showMyInformation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    override func style() {
        super.style()

        homeTopView.mainMessageLabel.text = "소중한 \(userName)님\n오늘도 약 꼭 챙겨 드세요"
        containerView.backgroundColor = .red
    }
    
    override func hierarchy() {
        view.addSubviews(homeTopView, containerView)
        embed(scheduleViewController, inView: containerView)
    }
    
    override func layout() {
        homeTopView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(28.adjustedHeight)
            $0.leading.trailing.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(homeTopView.snp.bottom)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
}

extension MainViewController {
    func showMyInformation() {
        homeTopView.completion = {
            let myInfoViewController = MyInfoViewController.instanceFromNib()
            self.navigationController?.pushViewController(myInfoViewController, animated: true)
        }
    }
}
