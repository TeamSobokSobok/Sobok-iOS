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
        hierarchy()
        layout()
    }
    
    public func style() {}
    public func hierarchy() {}
    public func layout() {}
}
