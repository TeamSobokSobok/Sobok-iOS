//
//  AddUserViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/29.
//

import UIKit

protocol AddUserProtocol: StyleProtocol, TargetProtocol {}

final class AddUserViewController: UIViewController, AddUserProtocol {
    
    private let addUserView = AddUserView()
    
    override func loadView() {
        self.view = addUserView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        target()
    }
    
    @objc func pushAddPillFirstView() {
    }
    
    func style() {
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
    
    func target() {
        addUserView.confirmButton.addTarget(self, action: #selector(pushAddPillFirstView), for: .touchUpInside)
    }
    
}
