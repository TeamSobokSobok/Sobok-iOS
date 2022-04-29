//
//  AddPillSecondViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/04/29.
//

import UIKit

final class AddPillSecondViewController: BaseViewController {
    
    let addPillSecondView = AddPillSecondView()
    
    override func loadView() {
        self.view = addPillSecondView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func style() {
        super.style()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
    }
}

