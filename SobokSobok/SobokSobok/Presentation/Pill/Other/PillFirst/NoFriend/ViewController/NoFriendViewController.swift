//
//  NoFriendViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/20.
//

import UIKit

import RxSwift
import RxCocoa

protocol NoFriendProtocol: BindProtocol, StyleProtocol {}

final class NoFriendViewController: UIViewController, NoFriendProtocol {
    
    private let noFriendView = NoFriendView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = noFriendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        style()
    }
    
    func bind() {
        self.noFriendView.navigationView.xButton.rx.tap.bind {
            self.navigationController?.popViewController(animated: true)
        }
        .disposed(by: disposeBag)
        
        self.noFriendView.addButton.rx.tap.bind {
            self.pushSearchNicknameViewController()
        }
        .disposed(by: disposeBag)
    }
    
    func style() {
        tabBarController?.tabBar.isHidden = true
        
        let navigation = noFriendView.navigationView
        
        [navigation.sendBottomFirstView,
         navigation.sendBottomSecondView,
         navigation.sendBottomThirdView,
         navigation.sendBottomFourthView]
            .forEach { $0.isHidden = true }
    }
    
    private func pushSearchNicknameViewController() {
        let viewController = SearchNicknameViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
