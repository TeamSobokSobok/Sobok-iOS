//
//  AddUserViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/29.
//

import UIKit

import RxSwift
import RxCocoa

protocol SelectFriendProtocol: StyleProtocol, TargetProtocol, BindProtocol {}

final class SelectFriendViewController: UIViewController, SelectFriendProtocol {
    
    private let selectFriendViewModel: SelectFriendViewModel
    
    private lazy var input = SelectFriendViewModel.Input(requestMemberList: requestMemberList.asSignal())
    
    private lazy var output = selectFriendViewModel.transform(input: input)
    
    private let requestMemberList = PublishRelay<Void>()
    private let disposeBag = DisposeBag()
    
    init(selectFriendViewModel: SelectFriendViewModel) {
        self.selectFriendViewModel = selectFriendViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let selectFriendView = SelectFriendView()
    
    override func loadView() {
        self.view = selectFriendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        target()
        bind()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestMemberList.accept(())
    }
    
    func bind() {
        output.didLoadMemberList.drive(selectFriendView.pickerView.rx.itemTitles) { (row, title) in

            return title
        
        }.disposed(by: disposeBag)
        
        selectFriendView.pickerView.rx.itemSelected.subscribe { (event) in
            switch event {
                case .next(let selected):
                    print(selected.row)
                default:
                    break
            }
        }
        .disposed(by: disposeBag)
    }
    
    @objc func pushAddPillFirstView() {
        
    }
    
    func style() {
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
    
    func target() {
        selectFriendView.confirmButton.addTarget(self, action: #selector(pushAddPillFirstView), for: .touchUpInside)
    }
}
