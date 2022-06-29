//
//  SendPillFirstViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/20.
//

import UIKit

final class SendPillFirstViewController: BaseViewController {

    let sendPillFirstView = SendPillFirstView()
    
    override func loadView() {
        self.view = sendPillFirstView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    
    }
    
    private func setupView() {
        sendPillFirstView.backgroundButton.addTarget(self, action: #selector(presentToUser), for: .touchUpInside)
    }
    
    @objc func presentToUser() {
        let viewController = AddUserViewController()
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
    }

}
