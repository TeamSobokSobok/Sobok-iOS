//
//  SendFillFirstViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/07/26.
//

import UIKit

import RxCocoa
import RxSwift

protocol SendPillFirstProtocol: StyleProtocol, TargetProtocol, BindProtocol, TossPillProtocol {}

final class SendPillFirstViewController: UIViewController, SendPillFirstProtocol {
    
    var type: TossPill = .friendPill
    
    private let disposeBag = DisposeBag()

    private let sendPillFirstView = SendPillFirstView()

    override func loadView() {
        self.view = sendPillFirstView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        target()
        bind()
    }

    func divide(style: PillStyle) {
        let navigationView = sendPillFirstView.navigationView
        
        navigationView.sendBottomFirstView.isHidden = style.bottomNavigationBarIsHidden
        
        navigationView.navigationTitleLabel.text = style.navigationTitle
    }
    
    func style() {
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .systemBackground
        sendPillFirstView.navigationView.xButton.setImage(Image.icClose48, for: .normal)
    }
    
    func target() {
        sendPillFirstView.nextButton.addTarget(self, action: #selector(pushAddPillFirstView), for: .touchUpInside)
        sendPillFirstView.backgroundButton.addTarget(self, action: #selector(presentToUser), for: .touchUpInside)
    }
    
    func bind() {
        sendPillFirstView.navigationView.xButton.rx.tap
            .bind {
                self.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }

    @objc func presentToUser() {
        let viewController = SelectFriendViewController(selectFriendViewModel: SelectFriendViewModel())
        viewController.sendNameDelegate = self
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
    }
    
    @objc func pushAddPillFirstView() {
        let addPillFirstView = AddPillFirstViewController(sendPillViewModel: SendPillViewModel())
        addPillFirstView.divide(style: .friendPill)
        addPillFirstView.type = .friendPill
        self.navigationController?.pushViewController(addPillFirstView, animated: true)
    }
}

extension SendPillFirstViewController: SendMemberNameDelegate {
    func sendMemberName(name: String) {
        sendPillFirstView.userLabel.text = name
    }
}
