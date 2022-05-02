//
//  AddPillThirdViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/04/30.
//

import UIKit

final class AddPillThirdViewController: BaseViewController {

    let addPillThirdView = AddPillThirdView()
    
    override func loadView() {
        self.view = addPillThirdView
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
