//
//  SendFillFirstViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/07/26.
//

import UIKit

import RxCocoa
import RxSwift

protocol SendPillFirstProtocol: StyleProtocol, TargetProtocol, TossPillProtocol {}

final class SendPillFirstViewController: UIViewController, SendPillFirstProtocol {
    
    var type: TossPill = .myPill

    private let sendPillFirstView = SendPillFirstView()

    override func loadView() {
        self.view = sendPillFirstView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        target()
    }

    private func divide(style: PillStyle) {
        let navigationView = sendPillFirstView.navigationView
        
        navigationView.sendBottomFirstView.isHidden = style.bottomNavigationBarIsHidden
    }
    
    func style() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func target() {
        sendPillFirstView.nextButton.addTarget(self, action: #selector(pushAddPillFirstView), for: .touchUpInside)
        
        sendPillFirstView.backgroundButton.addTarget(self, action: #selector(presentToUser), for: .touchUpInside)
    }

    @objc func presentToUser() {
        let viewController = SelectFriendViewController(selectFriendViewModel: SelectFriendViewModel())
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
    }
    
    @objc func pushAddPillFirstView() {
        let addPillFirstView = AddPillFirstViewController(sendPillViewModel: SendPillViewModel())
        addPillFirstView.divide(style: .friendPill)
        self.navigationController?.pushViewController(addPillFirstView, animated: true)
    }
}
