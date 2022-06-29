//
//  AddUserViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/29.
//

import UIKit

final class AddUserViewController: BaseViewController {
    
    private let addUserView = AddUserView()
    
    override func loadView() {
        self.view = addUserView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
}
