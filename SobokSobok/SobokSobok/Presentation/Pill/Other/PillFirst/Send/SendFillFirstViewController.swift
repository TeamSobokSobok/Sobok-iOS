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
    var viewModel: SendPillViewModel
    private let disposeBag = DisposeBag()

    private let sendPillFirstView = SendPillFirstView()
    
    private let member = UserDefaults.standard.member
    
    init(viewModel: SendPillViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        self.sendPillFirstView.userLabel.text = member.first?.memberName
        
        self.viewModel.memberId.value = member.first!.memberId
        
        self.viewModel.userName = member.first!.memberName
        
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
        let addPillFirstView = AddPillFirstViewController(sendPillViewModel: viewModel)
        addPillFirstView.divide(style: .friendPill)
        addPillFirstView.type = .friendPill
        self.navigationController?.pushViewController(addPillFirstView, animated: true)
    }
}

extension SendPillFirstViewController: SendMemberDelegate {
    func sendMember(name: String, id: Int) {
        sendPillFirstView.userLabel.text = name
        viewModel.memberId.value = id
        viewModel.userName = name
    }
}
