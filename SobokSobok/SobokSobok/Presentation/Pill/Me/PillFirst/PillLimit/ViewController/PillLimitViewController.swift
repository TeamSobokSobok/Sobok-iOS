//
//  PillLimitViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/20.
//

import UIKit

protocol PillLimitProtocol: StyleProtocol, TargetProtocol {}

final class PillLimitViewController: UIViewController, PillLimitProtocol {

    let pillLimitView = PillLimitView()
    
    override func loadView() {
        self.view = pillLimitView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        target()
    }

    func style() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func target() {
        pillLimitView.xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
    }
    
    @objc func xButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
