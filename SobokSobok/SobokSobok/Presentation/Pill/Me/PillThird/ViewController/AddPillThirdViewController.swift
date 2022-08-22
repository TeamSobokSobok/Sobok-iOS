//
//  AddPillThirdViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/04/30.
//

import UIKit

import RxCocoa
import RxSwift

protocol AddPillThirdProtocol: TargetProtocol, BindProtocol, TossPillProtocol, StyleProtocol {}

final class AddPillThirdViewController: UIViewController, AddPillThirdProtocol {
    
    private let disposeBag = DisposeBag()
    var type: TossPill = .myPill
    private let addPillThirdView = AddPillThirdView()
    private let firstPillNameView = FirstPillNameView(frame: CGRect(), sendPillViewModel: SendPillViewModel())
    private let addPillInfoView = AddPillInfoView()
    private let sendPillViewModel: SendPillViewModel
    let pillThirdViewModel: PillThirdViewModel
    
    init(sendPillViewModel: SendPillViewModel, pillThirdViewModel: PillThirdViewModel) {
        self.sendPillViewModel = sendPillViewModel
        self.pillThirdViewModel = pillThirdViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = addPillThirdView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        target()
        bind()
        style()
        didTappedView()
        addPill()
    }
    
    private func addPill() {
        addPillThirdView.footerView.addPillButton.rx.tap.bind {
            self.bind()
            if self.addPillThirdView.wholeStackView.arrangedSubviews.count >= 5 {
                self.addPillThirdView.footerView.isHidden = true
            } else {
                self.addPillThirdView.footerView.isHidden = false
            }
        }
        .disposed(by: disposeBag)
    }

    func style() {
        self.view.backgroundColor = Color.white
    }
    
    func bind() {
        addPillThirdView.navigationView.xButton.rx.tap.bind {
            self.navigationController?.popViewController(animated: true)
        }
        .disposed(by: disposeBag)
        
        addPillThirdView.navigationView.cancelButton.rx.tap.bind {
            
            let viewController = StopPillViewController()
            
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overFullScreen
            
            self.present(viewController, animated: true)
        }
        .disposed(by: disposeBag)
        
        if self.addPillThirdView.wholeStackView.arrangedSubviews.count >= 6 {
            self.addPillThirdView.footerView.isHidden = true
        } else {
            self.addPillThirdView.footerView.isHidden = false
        }
        
        let pillNameView = FirstPillNameView(frame: CGRect(), sendPillViewModel: sendPillViewModel)
        let count = self.addPillThirdView.wholeStackView.arrangedSubviews.count
        pillNameView.deleteCellButton.tag = count == 0 ? 0 : count
        pillNameView.pillNameTextField.tag = count == 0 ? 0 : count
        pillNameView.tag = pillNameView.deleteCellButton.tag
        pillNameView.tag = pillNameView.pillNameTextField.tag
        
        sendPillViewModel.tag = pillNameView.tag
        
        self.sendPillViewModel.pillName.insert("", at: sendPillViewModel.tag)
        self.addPillThirdView.wholeStackView.addArrangedSubview(pillNameView)
        
        self.sendPillViewModel.count.value = count
        sendPillViewModel.isTrue.bind { _ in
            if self.sendPillViewModel.isTrue.value {
                self.enableNextButton()
            } else {
                self.unableNextButton()
            }
        }
        
        pillNameView.deleteCellButton.rx.tap.bind {
            let tag = pillNameView.deleteCellButton.tag
            let textFieldTag = pillNameView.pillNameTextField.tag
            
            self.sendPillViewModel.tag = textFieldTag
            
            self.sendPillViewModel.pillName.remove(at: self.sendPillViewModel.tag)
            
            if self.addPillThirdView.wholeStackView.arrangedSubviews.count >= 6 {
                self.addPillThirdView.footerView.isHidden = true
            } else {
                self.addPillThirdView.footerView.isHidden = false
            }
            
            guard let firstPillNameView = self.addPillThirdView.wholeStackView.subviews.first(where: { $0.tag == tag })?.removeFromSuperview() as? FirstPillNameView else { return }
            
            self.addPillThirdView.wholeStackView.removeArrangedSubview(firstPillNameView)
        }
        .disposed(by: self.disposeBag)
        
        if self.addPillThirdView.wholeStackView.arrangedSubviews.count >= 6 {
            self.addPillThirdView.footerView.isHidden = true
        } else {
            self.addPillThirdView.footerView.isHidden = false
        }
    }
    
    func didTappedView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(hideToolTipImage))
        view.addGestureRecognizer(tap)
    }
    
    @objc func hideToolTipImage() {
        addPillThirdView.tooltipImage.isHidden = true
    }
    
    func target() {
        addPillThirdView.nextButton.addTarget(self, action: #selector(divideType), for: .touchUpInside)
        
        addPillThirdView.countInfoButton.addTarget(self, action: #selector(openToolTipImage), for: .touchUpInside)
    }
    
    @objc func openToolTipImage() {
        addPillThirdView.tooltipImage.isHidden = false
    }
    
    private func presentView() {
        let bottomSheetVC = AddPillInfoViewController(sendPillViewModel: sendPillViewModel)
        bottomSheetVC.modalPresentationStyle = .overFullScreen
        bottomSheetVC.modalTransitionStyle = .crossDissolve
        self.present(bottomSheetVC, animated: false)
    }
    
    private func postMyPill() {
        sendPillViewModel.postFriendPill()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func divideType() {
        switch type {
        case .myPill:
            postMyPill()
        case .friendPill:
            presentView()
        }
    }
    
    private func enableNextButton() {
        addPillThirdView.nextButton.backgroundColor = Color.mint
        addPillThirdView.nextButton.setTitleColor(Color.white, for: .normal)
        addPillThirdView.nextButton.isEnabled = true
    }
    
    private func unableNextButton() {
        addPillThirdView.nextButton.backgroundColor = Color.gray200
        addPillThirdView.nextButton.setTitleColor(Color.gray500, for: .normal)
        addPillThirdView.nextButton.isEnabled = false
    }
    
    func divide(style: PillStyle) {
        
        let navigationView = addPillThirdView.navigationView
        
        type = style.type
        
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
}
