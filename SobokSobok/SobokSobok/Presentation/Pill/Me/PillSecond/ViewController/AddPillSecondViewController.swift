//
//  AddPillSecondViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/04/29.
//

import UIKit

protocol AddPillSecondProtocol: StyleProtocol, TargetProtocol, TossPillProtocol {}

final class AddPillSecondViewController: UIViewController, AddPillSecondProtocol {
    var type: TossPill = .myPill
    let addPillSecondView = AddPillSecondView()
    
    override func loadView() {
        self.view = addPillSecondView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        target()
    }

    func target() {
        addPillSecondView.nextButton.addTarget(self, action: #selector(pushAddPillThirdView), for: .touchUpInside)
    }
    
    @objc func pushAddPillThirdView() {
        switch type {
        case .myPill:
            pushViewController(style: .myPill)
        case .friendPill:
            pushViewController(style: .friendPill)
        }
    }
    
    private func pushViewController(style: PillStyle) {
        let addPillThirdView = AddPillThirdViewController()
        addPillThirdView.divide(style: style)
        self.navigationController?.pushViewController(addPillThirdView, animated: true)
    }
    
    func divide(style: PillStyle) {
        
        type = style.type
        
        let navigationView = addPillSecondView.navigationView
        
        [navigationView.bottomFirstView,
         navigationView.bottomSecondView].forEach {
            $0.isHidden = style.bottomNavigationBarIsHidden
        }
        
        [navigationView.sendBottomFirstView,
         navigationView.sendBottomSecondView,
         navigationView.sendBottomThirdView].forEach {
            $0.isHidden = style.sendBottomNavigationBarIsHidden
        }
    }
    
    func style() {
        tabBarController?.tabBar.isHidden = true
    }
}
