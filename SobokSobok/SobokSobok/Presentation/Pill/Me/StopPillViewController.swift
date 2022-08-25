//
//  StopPillViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/15.
//

import UIKit

import RxCocoa
import RxSwift

protocol StopPillProtocol: BindProtocol, StyleProtocol {}

final class StopPillViewController: UIViewController, StopPillProtocol {
    
    private let stopPillView = StopPillView()
    
    private let disposeBag = DisposeBag()
    
    var navigation: UINavigationController
    
    override func loadView() {
        self.view = stopPillView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        bind()
    }
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
    
    func bind() {
        stopPillView.continueButton.rx.tap.bind {
            self.dismiss(animated: true)
        }
        .disposed(by: disposeBag)
        
        stopPillView.stopButton.rx.tap.bind {
            self.dismiss(animated: false) {
                self.navigation.popToRootViewController(animated: true)
            }
        }
        .disposed(by: disposeBag)
    }
}
