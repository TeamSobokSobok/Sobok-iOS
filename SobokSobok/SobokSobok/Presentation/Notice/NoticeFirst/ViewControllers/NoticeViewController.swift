//
//  NoticeViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/09.
//

import UIKit

final class NoticeViewController: BaseViewController {
    
    // MARK: - Properties
    private var noticeList: [NoticeListData] = NoticeListData.dummy
    private let emptyView = EmptyView()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        assignDelegation()
//        registerXib()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func loadView() {
        view = emptyView
    }
    
    override func style() {
        super.style()
        view.backgroundColor = Color.gray150
    }
    
    // MARK: - Functions
    func assignDelegation() {
       
    }
    
    func registerXib() {
        
    }
}
