//
//  AddSuccessFriendViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/10/29.
//

import UIKit

import RxCocoa
import RxSwift

final class AddSuccessFriendViewController: UIViewController {
    
    lazy var addSuccessView = AddSuccessView()
    
    private let disposeBag = DisposeBag()
    
    var navigation: UINavigationController?
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = addSuccessView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        style()
        bind()
    }
    
    private func style() {
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }

    private func bind() {
    
        addSuccessView.confirmButton.rx.tap.bind {
            self.presentingViewController?.presentingViewController?.dismiss(animated: true) {
                self.presentingViewController?.presentingViewController?.navigationController?.popToRootViewController(animated: true)
            }
        }
        .disposed(by: disposeBag)
    }
}
