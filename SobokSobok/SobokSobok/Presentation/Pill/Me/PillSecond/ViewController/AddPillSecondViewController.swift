//
//  AddPillSecondViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/04/29.
//

import UIKit

import RxCocoa
import RxSwift

protocol AddPillSecondProtocol: StyleProtocol, TargetProtocol, TossPillProtocol, DelegationProtocol, BindProtocol, CalendarViewDelegate {}

final class AddPillSecondViewController: UIViewController, AddPillSecondProtocol {
   
    var type: TossPill = .myPill
    private let addPillSecondView = AddPillSecondView()
    private let sendPillViewModel: SendPillViewModel
    private let disposeBag = DisposeBag()
    
    init(sendPillViewModel: SendPillViewModel) {
        self.sendPillViewModel = sendPillViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = addPillSecondView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        target()
        bind()
        assignDelegation()
    }
    
    func assignDelegation() {
        addPillSecondView.calendar.delegate = self
    }
    
    
    func style() {
        self.view.backgroundColor = Color.white
    }
    
    func bind() {
        addPillSecondView.navigationView.xButton.rx.tap.bind {
            self.navigationController?.popViewController(animated: true)
        }
        .disposed(by: disposeBag)
        
        addPillSecondView.navigationView.cancelButton.rx.tap.bind {
                let viewController = StopPillViewController(
                    navigation: self.navigationController!
                )
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .overFullScreen
                self.present(viewController, animated: true)
        }
        .disposed(by: disposeBag)
        
        let date = Date()
        
        guard let afterDate = Calendar.current.date(byAdding: .day, value: 92, to: date) else { return }

        self.addPillSecondView.pillPeriodLabel.text = "\(date.toString(of: .year)) ~ \(afterDate.toString(of: .year))"
        
        self.addPillSecondView.checkBoxButton.rx.tap.bind {
            self.addPillSecondView.checkBoxButton.isSelected.toggle()
             
            if self.addPillSecondView.checkBoxButton.isSelected {
                self.addPillSecondView.checkBoxButton.setImage(Image.icCheckButton48, for: .normal)
                self.unableNextButton()
            } else {
                self.addPillSecondView.checkBoxButton.setImage(Image.icChecked, for: .normal)
                self.enableNextButton()
            }

            self.addPillSecondView.calendar.calculateThreeMonthRange(isCheckedThreeMonthState: self.addPillSecondView.checkBoxButton.isSelected)
      
        }
        .disposed(by: disposeBag)
    }
    
    func didSelectFirstDate(_ calendar: CalendarView) {
        if self.addPillSecondView.calendar.firstDate == nil {

            self.addPillSecondView.checkBoxButton.setImage(Image.icCheckButton48, for: .normal)
            self.unableNextButton()
        }
        
        guard let calendar = calendar.firstDate else { return }
        
        self.sendPillViewModel.start = calendar.toString(of: .year)
        
        self.addPillSecondView.pillPeriodLabel.text = "\(sendPillViewModel.start) ~ \(sendPillViewModel.end)"
     
    }
    
    func didSelectLastDate(_ calendar: CalendarView) {
        guard let calendar = calendar.lastDate else { return }
        
        self.sendPillViewModel.end = calendar.toString(of: .year)
    
        self.addPillSecondView.pillPeriodLabel.text = "\(sendPillViewModel.start) ~ \(sendPillViewModel.end)"
        
        if self.addPillSecondView.calendar.firstDate != nil && self.addPillSecondView.calendar.lastDate != nil {
            self.enableNextButton()
        }
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
        let addPillThirdView = AddPillThirdViewController(sendPillViewModel: sendPillViewModel)
        addPillThirdView.divide(style: style)
        addPillThirdView.type = style.type
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
        
        navigationView.navigationTitleLabel.text = style.navigationTitle
    }
    
    private func enableNextButton() {
        addPillSecondView.nextButton.backgroundColor = Color.mint
        addPillSecondView.nextButton.setTitleColor(Color.white, for: .normal)
        addPillSecondView.nextButton.isEnabled = true
    }
    
    private func unableNextButton() {
        addPillSecondView.nextButton.backgroundColor = Color.gray200
        addPillSecondView.nextButton.setTitleColor(Color.gray500, for: .normal)
        addPillSecondView.nextButton.isEnabled = false
    }
}
