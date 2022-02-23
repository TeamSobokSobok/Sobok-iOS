//
//  ButtonViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/02/19.
//

import UIKit

import SnapKit
import Then

final class ButtonViewController: BaseViewController {

    let buttonView = ButtonView()
    
    override func loadView() {
        self.view = buttonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func style() {
        view.backgroundColor = .white
    }
}
