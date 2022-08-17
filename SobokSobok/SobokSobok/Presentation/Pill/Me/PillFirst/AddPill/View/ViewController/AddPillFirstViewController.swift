//
//  AddPillFirstViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/01.
//

import UIKit

import RxSwift
import RxCocoa

protocol AddPillFirstProtocol: StyleProtocol, BindProtocol, TossPillProtocol {}

final class AddPillFirstViewController: UIViewController, AddPillFirstProtocol {
    
    private lazy var input = AddPillFirstViewModel.Input(
        didEverydayButtonTap: addPillFirstView.everydayButton.rx.tap.asSignal(),
        didSpecificDayButtonTap: addPillFirstView.specificDayButton.rx.tap.asSignal(),
        didSpecificPeriodButtonTap: addPillFirstView.specificPeriodButton.rx.tap.asSignal(),
        selectPeriodButtonTap: addPillFirstView.specificView.backgroundButton.rx.tap.asSignal()
    )
    var type: TossPill = .myPill
    var specific: Specific?
    private lazy var output = viewModel.transform(input: input)
    private let disposeBag = DisposeBag()
    private let addPillFirstView = AddPillFirstView()
    private var pillDayViewModel = PillDayViewModel()
    private var viewModel = AddPillFirstViewModel()
    private var addPillTimeViewModel = AddTimeViewModel()
    private var pillTimeViewModel = PillTimeViewModel()
    private var pillPeriodViewModel = PillPeriodViewModel()
    private var sendPillViewModel: SendPillViewModel
    
    override func loadView() {
        self.view = addPillFirstView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        style()
        bind()
        print(type)
    }
    
    init(sendPillViewModel: SendPillViewModel) {
        self.sendPillViewModel = sendPillViewModel
        super.init(nibName: nil, bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func divide(style: PillStyle) {
        let navigationView = addPillFirstView.navigationView
        
        navigationView.bottomFirstView.isHidden = style.bottomNavigationBarIsHidden
        
        [navigationView.sendBottomFirstView,
         navigationView.sendBottomSecondView].forEach {
            $0.isHidden = style.sendBottomNavigationBarIsHidden
        }
        
        navigationView.navigationTitleLabel.text = style.navigationTitle
    }
    
    func style() {
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = .systemBackground
    }
    
    func bind() {
        addPillFirstView.navigationView.xButton.rx.tap.bind {
            self.navigationController?.popViewController(animated: true)
        }
        .disposed(by: disposeBag)
        
        addPillFirstView.navigationView.cancelButton.rx.tap.bind {
            
            let viewController = StopPillViewController()
            
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .overFullScreen
            
            self.present(viewController, animated: true)
        }
        .disposed(by: disposeBag)
        
        addPillFirstView.everydayButton.rx.tap.bind {
            self.addPillFirstView.everydayButton.isSelected.toggle()
            if self.addPillFirstView.everydayButton.isSelected {
                self.enableNextButton()
                self.sendPillViewModel.takeInterval = 1
                self.sendPillViewModel.day = ""
            } else {
                self.unableNextButton()
            }
        }
        .disposed(by: disposeBag)
        
        addPillFirstView.specificDayButton.rx.tap
            .bind {
                self.pillPeriodViewModel.dayPeriod.value = "며칠 간격으로 먹나요?"
                self.sendPillViewModel.takeInterval = 2
                self.sendPillViewModel.day = self.pillDayViewModel.days.value
                self.unableNextButton()
            }
            .disposed(by: disposeBag)
        
        addPillFirstView.specificPeriodButton.rx.tap
            .bind {
                self.pillDayViewModel.days.value = "무슨 요일에 먹나요?"
                self.sendPillViewModel.takeInterval = 3
                self.sendPillViewModel.specific = self.pillPeriodViewModel.dayString.value.changeKrToEn()
                
                self.unableNextButton()
            }
            .disposed(by: disposeBag)
        
        addPillFirstView.specificView.backgroundButton.rx.tap
            .bind {
                switch self.addPillFirstView.specific {
                case .everyday:
                    print("everyday")
                case .day:
                    self.presentView()
                case .period:
                    self.presentPeriodView()
                default:
                break
                }
            }
            .disposed(by: disposeBag)
        
        addPillFirstView.nextButton.rx.tap
            .bind {
                switch self.type {
                case .myPill:
                    self.pushSecondView(style: .myPill)
                case .friendPill:
                    self.pushSecondView(style: .friendPill)
                }
            }
            .disposed(by: disposeBag)
    
        output.isEverydaySelected
            .drive(onNext: {
                self.addPillFirstView.everydayButton.isSelected = $0
                self.addPillFirstView.specificView.isHidden = true
                })
            .disposed(by: disposeBag)
        
        output.isSpecificDaySelected
            .drive(onNext: {
                self.addPillFirstView.specificDayButton.isSelected = $0
                self.addPillFirstView.specificView.specificLabel.text = "무슨 요일에 먹나요?"
                self.addPillFirstView.specificView.isHidden = !$0
                self.addPillFirstView.specific = .day
            })
            .disposed(by: disposeBag)
        
        output.isSpecificPeriodSelected
            .drive(onNext: {
                self.addPillFirstView.specificPeriodButton.isSelected = $0
                self.addPillFirstView.specificView.specificLabel.text = "며칠 간격으로 먹나요?"
                self.addPillFirstView.specificView.isHidden = !$0
                self.addPillFirstView.specific = .period
                })
            .disposed(by: disposeBag)
        
        pillTimeViewModel.timeList.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.addPillFirstView.collectionView.reloadData()
            }
        }
        
        pillDayViewModel.days.bind { [weak self] (text) in
            guard let self = self else { return }
            self.addPillFirstView.specificView.specificLabel.text = text
            if text == "" {
                self.unableNextButton()
            } else {
                self.enableNextButton()
            }
        }
        
        pillPeriodViewModel.dayString.bind { [weak self] (text) in
            guard let self = self else { return }
            self.addPillFirstView.specificView.specificLabel.text = text
            if text == "" {
                self.unableNextButton()
            } else {
                self.enableNextButton()
            }
        }
    }
        
    private func assignDelegation() {
        addPillFirstView.collectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        addPillFirstView.collectionView.rx.setDataSource(self)
            .disposed(by: disposeBag)
    }
    
    private func enableNextButton() {
        addPillFirstView.nextButton.backgroundColor = Color.mint
        addPillFirstView.nextButton.setTitleColor(Color.white, for: .normal)
        addPillFirstView.nextButton.isEnabled = true
        addPillFirstView.specificView.specificLabel.textColor = Color.black
    }
    
    private func unableNextButton() {
        addPillFirstView.nextButton.backgroundColor = Color.gray200
        addPillFirstView.nextButton.setTitleColor(Color.gray500, for: .normal)
        addPillFirstView.nextButton.isEnabled = false
        addPillFirstView.specificView.specificLabel.textColor = Color.gray500
    }
}

extension AddPillFirstViewController {
    private func presentView() {
        let viewController = PillDayViewController()
        viewController.sendPillDays = self
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
    }
    
    private func presentTimeView() {
        let viewController = AddTimeViewController()
        viewController.sendPillTime = self
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
    }
    
    private func presentPeriodView() {
        let viewController = PillPeriodViewController()
        viewController.sendPillPeriod = self
        viewController.modalPresentationStyle = .overFullScreen
        viewController.modalTransitionStyle = .crossDissolve
        self.present(viewController, animated: true)
    }
    
    private func pushSecondView(style: PillStyle) {
        let addPillSecondViewController = AddPillSecondViewController(sendPillViewModel: sendPillViewModel)
        addPillSecondViewController.divide(style: style)
        addPillSecondViewController.type = style.type
        
        self.navigationController?.pushViewController(addPillSecondViewController, animated: true)
    }
}

extension AddPillFirstViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pillTimeViewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PillTimeCollectionViewCell.self)
        
        cell.updateCell(pillTimeViewModel, indexPath: indexPath)
        
        sendPillViewModel.time = pillTimeViewModel.timeList.value
        
        cell.viewModel.deleteCellClosure = { [weak self] in
            guard let self = self else { return }
            self.pillTimeViewModel.deleteCell(index: indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddPillFirstFooterView.reuseIdentifier, for: indexPath) as? AddPillFirstFooterView else { return UICollectionReusableView()}
       
        cell.addTimeButton.currentImage?.withTintColor(.red)
        
        cell.viewModel.addCellClosure = { [weak self] in
            guard let self = self else { return }
            self.presentTimeView()
        }
        
        self.pillTimeViewModel.hideFooterView(button: &cell.addTimeButton.isHidden)
        
        return cell
    }
}

extension AddPillFirstViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 40)
    }
}

extension AddPillFirstViewController: SendPillTimeDelegate, SendPillDaysDelegate, SendPillPeriodDelegate {
    func snedPillTime(pillTime: String) {
        pillTimeViewModel.addPillTime(pillTime: pillTime)
    }
    
    func sendPillDays(pillDays: String) {
        pillDayViewModel.days.value = pillDays.addSeparator()
        sendPillViewModel.day = pillDays.addSeparator()
    }
    
    func sendPillPeriod(pillPeriod: String) {
        pillPeriodViewModel.dayString.value = pillPeriod
        sendPillViewModel.specific = pillPeriod
    }
}
