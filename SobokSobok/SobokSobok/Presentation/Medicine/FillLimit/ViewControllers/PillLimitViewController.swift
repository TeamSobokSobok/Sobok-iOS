//
//  PillLimitViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/20.
//

import UIKit

final class PillLimitViewController: BaseViewController {

    let pillLimitView = PillLimitView()
    
    override func loadView() {
        self.view = pillLimitView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func style() {
        super.style()
        view.backgroundColor = .white
    }
}
