//
//  BaseViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/07.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        target()
        hierarchy()
        layout()
    }
    
    func target() { }
    func style() {
        navigationController?.navigationBar.isHidden = true
    }
    func hierarchy() {}
    func layout() {}
    
}
