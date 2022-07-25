//
//  NoFriendViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/20.
//

import UIKit

protocol NoFriendProtocol: TargetProtocol {}

final class NoFriendViewController: UIViewController, NoFriendProtocol {

    let noFriendView = NoFriendView()
    
    override func loadView() {
        self.view = noFriendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func target() {

    }
    
}
