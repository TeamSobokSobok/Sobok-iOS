//
//  SendInfoViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

final class PillInfoViewController: BaseViewController {
    
    // MARK: - Properties
    private var pillInfoList: [SendInfoListData] = SendInfoListData.dummy
    private let pillInfoView = PillInfoView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = pillInfoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    }
}
