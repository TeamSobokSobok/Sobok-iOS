//
//  EditViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/12.
//

import UIKit

import RxCocoa
import RxSwift

protocol EditViewProtocol: DelegationProtocol, BindProtocol, StyleProtocol {}

final class EditViewController: UIViewController, EditViewProtocol {
    
    private lazy var input = AddPillFirstViewModel.Input(
        didEverydayButtonTap: editView.editPillPeriodView.everydayButton.rx.tap.asSignal(),
        didSpecificDayButtonTap: editView.editPillPeriodView.specificDayButton.rx.tap.asSignal(),
        didSpecificPeriodButtonTap: editView.editPillPeriodView.specificPeriodButton.rx.tap.asSignal(),
        selectPeriodButtonTap: editView.editPillPeriodView.specificView.backgroundButton.rx.tap.asSignal()
    )
    
    private lazy var output = viewModel.addPillFirstViewModel.transform(input: input)
    private let disposeBag = DisposeBag()
    
    private let changeBool: Helper<Bool> = Helper(false)
    
    private let viewModel: EditCommonViewModel
    
    private let editView = EditView()
    
    private let pillTextFieldText: BehaviorSubject<String> = BehaviorSubject(value: "")
    private let textFieldValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)

    init(viewModel: EditCommonViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = editView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        bind()
        style()
    }
    
    private func checkValid(_ text: String) -> Bool {
        return text.count > 0
    }
    
    func style() {
        view.backgroundColor = Color.white
        tabBarController?.tabBar.isHidden = true
        editView.navigationView.navigationTitleLabel.text = "내 약 수정"
    }
    
    func bind() {
        viewModel.textFieldText.value = editView.editPillNameView.pillNameTextField.text!
        
        viewModel.timeViewModel.timeList.bind { [weak self] _ in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.editView.editPillTimeView.collectionView.reloadData()
            }
            self.divide()
        }
        
        editView.editPillNameView.pillNameTextField.rx.text
            .orEmpty
            .bind(to: pillTextFieldText)
            .disposed(by: disposeBag)
        
        pillTextFieldText
            .map(checkValid)
            .bind(to: textFieldValid)
            .disposed(by: disposeBag)
        
        textFieldValid.subscribe(on: MainScheduler.instance)
            .subscribe(onNext: { _ in
                self.divide()
            })
            .disposed(by: disposeBag)
        
        editView.navigationView.xButton.rx.tap.bind {
            self.showAlert(
                title: "",
                message: "저장하지 않고 나가면 수정한 내용이 반영되지 않아요. 그래도 나갈까요?",
                completionTitle: "나가기",
                cancelTitle: "취소"
            )
        }
        .disposed(by: disposeBag)
        
        editView.navigationView.cancelButton.rx.tap.bind {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(UIAlertAction(title: "복약 중단", style: .default, handler: { _ in
                let alert = UIAlertController(title: "정말로 복약을 중단하나요?", message: "복약을 중단하면 내일부터 약 알림이 오지 않아요.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "취소", style: .default) { _ in
                    print("11")
                }
                
                let stopAction = UIAlertAction(title: "복약 중단", style: .destructive) { _ in
                    print("")
                }
                [cancelAction, stopAction].forEach {
                    alert.addAction($0)
                }
                self.present(alert, animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "약 삭제", style: .destructive, handler: { _ in
                let alert = UIAlertController(title: "정말로 약을 삭제하나요?", message: "해당 약에 대한 전체 복약 기록이 사라지고 알림도 오지 않아요.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "취소", style: .default) { _ in
                    print("11")
                }
                
                let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
                    print("삭제")
                }
                [cancelAction, deleteAction].forEach {
                    alert.addAction($0)
                }
                
                self.present(alert, animated: true)
            }))
            alert.addAction(cancel)
            
            self.present(alert, animated: true)
        }
        .disposed(by: disposeBag)
        
        editView.editPillPeriodView.everydayButton.rx.tap.bind {
            self.viewModel.dayViewModel.days.value = ""
            self.viewModel.periodViewModel.dayString.value = ""
            self.editView.editPillPeriodView.everydayButton.isSelected.toggle()
            
            self.changeBool.value = self.editView.editPillPeriodView.everydayButton.isSelected
            
        }
        .disposed(by: disposeBag)
        
        editView.editPillPeriodView.specificDayButton.rx.tap
            .bind {
                self.changeBool.value = false
                self.viewModel.periodViewModel.dayString.value = ""
                self.editView.editPillPeriodView.specificView.specificLabel.textColor = Color.gray600
                self.viewModel.periodViewModel.dayPeriod.value = "며칠 간격으로 먹나요?"
                self.unableNextButton()
            }
            .disposed(by: disposeBag)
        
        editView.editPillPeriodView.specificPeriodButton.rx.tap
            .bind {
                self.viewModel.dayViewModel.days.value = ""
                self.changeBool.value = false
                self.viewModel.dayViewModel.days.value = "무슨 요일에 먹나요?"
                self.editView.editPillPeriodView.specificView.specificLabel.textColor = Color.gray600
                self.unableNextButton()
            }
            .disposed(by: disposeBag)
        
        editView.editPillPeriodView.specificView.backgroundButton.rx.tap
            .bind {
                switch self.editView.editPillPeriodView.specific {
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
        
        viewModel.dayViewModel.days.bind { [weak self] (text) in
            guard let self = self else { return }
            self.editView.editPillPeriodView.specificView.specificLabel.text = text
            guard let textField = self.editView.editPillNameView.pillNameTextField.text else { return }
            self.editView.editPillPeriodView.specificView.specificLabel.textColor = Color.black
            if text == "" || textField.count == 0 || self.viewModel.timeViewModel.timeList.value.count == 0 {
                self.unableNextButton()
            } else {
                self.enableNextButton()
            }
        }
        
        changeBool.bind { [weak self] bool in
            guard let self = self else { return }
            guard let textField = self.editView.editPillNameView.pillNameTextField.text else { return }
            
            if bool == false || self.viewModel.timeViewModel.timeList.value.count == 0 || textField.count == 0 {
                self.unableNextButton()
            } else {
                self.enableNextButton()
            }
        }
        
        viewModel.periodViewModel.dayString.bind { [weak self] (text) in
            guard let self = self else { return }
            self.editView.editPillPeriodView.specificView.specificLabel.text = text
            self.editView.editPillPeriodView.specificView.specificLabel.textColor = Color.black
            self.divide()
        }
        
        output.isEverydaySelected
            .drive(onNext: {
                self.editView.editPillPeriodView.everydayButton.isSelected = $0
                self.editView.editPillPeriodView.specificView.isHidden = true
                self.editView.editPillPeriodView.specific = .everyday
            })
            .disposed(by: disposeBag)
        
        output.isSpecificDaySelected
            .drive(onNext: {
                self.editView.editPillPeriodView.specificDayButton.isSelected = $0
                self.editView.editPillPeriodView.specificView.specificLabel.text = "무슨 요일에 먹나요?"
                self.editView.editPillPeriodView.specificView.isHidden = !$0
                self.editView.editPillPeriodView.specific = .day
            })
            .disposed(by: disposeBag)
        
        output.isSpecificPeriodSelected
            .drive(onNext: {
                self.editView.editPillPeriodView.specificPeriodButton.isSelected = $0
                self.editView.editPillPeriodView.specificView.specificLabel.text = "며칠 간격으로 먹나요?"
                self.editView.editPillPeriodView.specificView.isHidden = !$0
                self.editView.editPillPeriodView.specific = .period
            })
            .disposed(by: disposeBag)
    }
    
    func assignDelegation() {
        editView.editPillTimeView.collectionView.delegate = self
        editView.editPillTimeView.collectionView.dataSource = self
    }
    
    func divide() {
        switch self.editView.editPillPeriodView.specific {
        case .everyday:
            guard let textField = self.editView.editPillNameView.pillNameTextField.text else { return }
            if self.changeBool.value == false || self.viewModel.timeViewModel.timeList.value.count == 0 || textField.count == 0 {
                self.unableNextButton()
            } else {
                self.enableNextButton()
            }
        case .day:
            guard let textField = self.editView.editPillNameView.pillNameTextField.text else { return }
            if self.viewModel.timeViewModel.timeList.value.count != 0 && self.viewModel.dayViewModel.days.value != "" && textField != "" {
                self.enableNextButton()
            } else {
                self.unableNextButton()
            }
        case .period:
            guard let textField = self.editView.editPillNameView.pillNameTextField.text else { return }
            
            if self.viewModel.timeViewModel.timeList.value.count != 0 && self.viewModel.periodViewModel.dayString.value != "" && textField != "" {
                self.enableNextButton()
            } else {
                self.unableNextButton()
            }
        case .none:
            break
        }
    }
}

extension EditViewController {
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
    
    private func enableNextButton() {
        editView.nextButton.backgroundColor = Color.mint
        editView.nextButton.setTitleColor(Color.white, for: .normal)
        editView.nextButton.isEnabled = true
    }
    
    private func unableNextButton() {
        editView.nextButton.backgroundColor = Color.gray200
        editView.nextButton.setTitleColor(Color.gray500, for: .normal)
        editView.nextButton.isEnabled = false
    }
}

extension EditViewController: UICollectionViewDelegate {}

extension EditViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.timeViewModel.timeList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PillTimeCollectionViewCell.self)
        
        cell.updateCell(viewModel.timeViewModel, indexPath: indexPath)
        
        cell.viewModel.deleteCellClosure = { [weak self] in
            guard let self = self else { return }
            self.viewModel.timeViewModel.deleteCell(index: indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddPillFirstFooterView.reuseIdentifier, for: indexPath) as? AddPillFirstFooterView else { return UICollectionReusableView()}
        
        cell.viewModel.addCellClosure = { [weak self] in
            guard let self = self else { return }
            self.presentTimeView()
        }
        
        self.viewModel.timeViewModel.hideFooterView(button: &cell.addTimeButton.isHidden)
        
        return cell
    }
}


extension EditViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 40)
    }
}

extension EditViewController: SendPillTimeDelegate, SendPillDaysDelegate, SendPillPeriodDelegate {
    func snedPillTime(pillTime: String) {
        viewModel.timeViewModel.addPillTime(pillTime: pillTime)
    }
    
    func sendPillDays(pillDays: String) {
        viewModel.dayViewModel.days.value = pillDays.addSeparator()
    }
    
    func sendPillPeriod(pillPeriod: String) {
        viewModel.periodViewModel.dayString.value = pillPeriod
    }
}
