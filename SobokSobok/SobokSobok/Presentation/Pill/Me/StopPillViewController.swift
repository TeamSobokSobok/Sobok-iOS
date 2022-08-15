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
    
    override func loadView() {
        self.view = stopPillView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        bind()
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
           
        }
        .disposed(by: disposeBag)
    }
}
