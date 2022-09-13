//
//  EditViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/12.
//

import UIKit

import RxCocoa
import RxSwift

protocol EditViewProtocol: DelegationProtocol, BindProtocol, StyleProtocol, TargetProtocol {}

final class EditViewController: UIViewController, EditViewProtocol {
    
    private lazy var input = AddPillFirstViewModel.Input(
        didEverydayButtonTap: editView.editPillPeriodView.everydayButton.rx.tap.asSignal(),
        didSpecificDayButtonTap: editView.editPillPeriodView.specificDayButton.rx.tap.asSignal(),
        didSpecificPeriodButtonTap: editView.editPillPeriodView.specificPeriodButton.rx.tap.asSignal(),
        selectPeriodButtonTap: editView.editPillPeriodView.specificView.backgroundButton.rx.tap.asSignal()
    )
    
    private lazy var output = editCommonViewModel.addPillFirstViewModel.transform(input: input)
    private let disposeBag = DisposeBag()
    private let changeBool: Helper<Bool> = Helper(false)
    private let editCommonViewModel: EditCommonViewModel
    private let editView = EditView()
    private let pillTextFieldText: BehaviorSubject<String> = BehaviorSubject(value: "")
    private let textFieldValid: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    init(viewModel: EditCommonViewModel) {
        self.editCommonViewModel = viewModel
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
        target()
    }
    
    func style() {
        view.backgroundColor = Color.white
        tabBarController?.tabBar.isHidden = true
        editView.navigationView.navigationTitleLabel.text = "내 약 수정"
    }
    
    func target() {
        editView.editPillNameView.pillNameTextField.addTarget(self, action: #selector(pillTextFieldDidChange(_:)), for: UIControl.Event.allEditingEvents)
    }

    func assignDelegation() {
        editView.editPillTimeView.collectionView.delegate = self
        editView.editPillTimeView.collectionView.dataSource = self
        editView.editPillNameView.pillNameTextField.delegate = self
    }
    
    func bind() {
        editCommonViewModel.pillName.bind { text in
            DispatchQueue.main.async {
                self.editView.editPillNameView.pillNameTextField.text =  self.editCommonViewModel.pillName.value
                self.editView.editPillNameView.pillNameCountLabel.text = "\(self.editCommonViewModel.pillName.value.count) / 10"
            }
        }
        
        editCommonViewModel.start.bind { text in
            self.editView.editPillDateView.pillDateLabel.text = "\(self.editCommonViewModel.start.value) ~ \(self.editCommonViewModel.end.value)"
        }
        
        editCommonViewModel.end.bind { text in
            self.editView.editPillDateView.pillDateLabel.text = "\(self.editCommonViewModel.start.value) ~ \(self.editCommonViewModel.end.value)"
        }
    
        editCommonViewModel.takeInterval.bind { value in
            DispatchQueue.main.async {
                switch value {
                case 1:
                    self.divideButtonState(everyday: true, day: false, period: false, type: .everyday)
                    
                    self.changeBool.value = self.editView.editPillPeriodView.everydayButton.isSelected
                case 2:
                    self.divideButtonState(everyday: false, day: true, period: false, type: .day)
                    
                    self.editView.editPillPeriodView.specificView.specificLabel.text = self.editCommonViewModel.dayViewModel.days.value
                    self.editView.editPillPeriodView.specificView.isHidden = false
  
                    if self.editCommonViewModel.dayViewModel.days.value == "무슨 요일에 먹나요?" {
                        self.unableNextButton()
                        self.editView.editPillPeriodView.specificView.specificLabel.textColor = Color.gray500
                    }
                case 3:
                    self.divideButtonState(everyday: false, day: false, period: true, type: .period)
                    self.editView.editPillPeriodView.specificView.isHidden = false
                    self.editView.editPillPeriodView.specificView.specificLabel.text = self.editCommonViewModel.periodViewModel.dayString.value.changeEnToKr()
       
                    if self.editCommonViewModel.periodViewModel.dayString.value == "며칠 간격으로 먹나요?" {
                        self.unableNextButton()
                        self.editView.editPillPeriodView.specificView.specificLabel.textColor = Color.gray500
                    }
                default:
                    break
                }
            }
        }
        
        editCommonViewModel.pillName.value = editView.editPillNameView.pillNameTextField.text!
        
        editCommonViewModel.timeViewModel.timeList.bind { _ in
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
                cancelTitle: "취소") { _ in
                    self.navigationController?.popViewController(animated: true)
                }
        }
        .disposed(by: disposeBag)
        
        editView.navigationView.cancelButton.rx.tap.bind {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            
            let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(UIAlertAction(title: "복약 중단", style: .default, handler: { _ in
                let alert = UIAlertController(title: "정말로 복약을 중단하나요?", message: "복약을 중단하면 내일부터 약 알림이 오지 않아요.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "취소", style: .default)
                
                let stopAction = UIAlertAction(title: "복약 중단", style: .destructive) { _ in
                    self.editCommonViewModel.stopPillList()
                    self.navigationController?.popToRootViewController(animated: true)
                }
                [cancelAction, stopAction].forEach {
                    alert.addAction($0)
                }
                self.present(alert, animated: true)
            }))
            
            alert.addAction(UIAlertAction(title: "약 삭제", style: .destructive, handler: { _ in
                let alert = UIAlertController(title: "정말로 약을 삭제하나요?", message: "해당 약에 대한 전체 복약 기록이 사라지고 알림도 오지 않아요.", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "취소", style: .default)
                
                let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
                    self.editCommonViewModel.deletePill()
                    self.navigationController?.popToRootViewController(animated: true)
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
            self.editView.editPillPeriodView.everydayButton.isSelected.toggle()
            self.changeBool.value = self.editView.editPillPeriodView.everydayButton.isSelected
            if self.editView.editPillPeriodView.everydayButton.isSelected {
                self.editCommonViewModel.dayViewModel.days.value = ""
                self.editCommonViewModel.takeInterval.value = 1
                self.editCommonViewModel.periodViewModel.dayString.value = ""
            } else {
                self.unableNextButton()
            }
        }
        .disposed(by: disposeBag)
        
        editView.editPillPeriodView.specificDayButton.rx.tap
            .bind {
                self.changeBool.value = false
                self.editCommonViewModel.takeInterval.value = 2
                self.editCommonViewModel.periodViewModel.dayString.value = ""
                self.editView.editPillPeriodView.specificView.specificLabel.textColor = Color.gray600
                self.editCommonViewModel.dayViewModel.days.value = "무슨 요일에 먹나요?"
                self.editCommonViewModel.periodViewModel.dayPeriod.value = ""
                self.unableNextButton()
            }
            .disposed(by: disposeBag)
        
        editView.editPillPeriodView.specificPeriodButton.rx.tap
            .bind {
                self.editCommonViewModel.dayViewModel.days.value = ""
                self.changeBool.value = false
                self.editCommonViewModel.periodViewModel.dayString.value = "며칠 간격으로 먹나요?"
                self.editCommonViewModel.takeInterval.value = 3
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
        
        editCommonViewModel.dayViewModel.days.bind { (text) in
            self.editView.editPillPeriodView.specificView.specificLabel.text = text
        
            
            guard let textField = self.editView.editPillNameView.pillNameTextField.text else { return }
            
            if text == "" || textField.count == 0 || self.editCommonViewModel.timeViewModel.timeList.value.count == 0 {
                self.unableNextButton()
            } else {
                self.enableNextButton()
            }
        }
        
        changeBool.bind { bool in
            DispatchQueue.main.async {
                guard let textField = self.editView.editPillNameView.pillNameTextField.text else { return }
                
                if bool == false || self.editCommonViewModel.timeViewModel.timeList.value.count == 0 || textField.count == 0 {
                    self.unableNextButton()
                } else {
                    self.enableNextButton()
                }
            }
        }
        
        editCommonViewModel.periodViewModel.dayString.bind { (text) in
   
            self.editView.editPillPeriodView.specificView.specificLabel.text = text
            text == "" ? self.unableNextButton() : self.enableNextButton()
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
        
        editView.nextButton.rx.tap.bind {
            self.editCommonViewModel.putEditPill(pillId: self.editCommonViewModel.pillId.value)
            self.navigationController?.popToRootViewController(animated: true)
        }
        .disposed(by: disposeBag)
    }

    @objc func pillTextFieldDidChange(_ textField: UITextField) {
        if let text = textField.text {
            editCommonViewModel.pillName.value = text
        }
    }
    
    private func checkValid(_ text: String) -> Bool {
        return text.count > 0
    }
    
    private func divideButtonState(everyday: Bool, day: Bool, period: Bool, type: Specific) {
        self.editView.editPillPeriodView.everydayButton.isSelected = everyday
        self.editView.editPillPeriodView.specificDayButton.isSelected = day
        self.editView.editPillPeriodView.specificPeriodButton.isSelected = period
        self.editView.editPillPeriodView.specific = type
        self.editView.editPillPeriodView.specificView.specificLabel.textColor = Color.black
        enableNextButton()
    }
    
    private func divide() {
        switch self.editView.editPillPeriodView.specific {
        case .everyday:
            guard let textField = self.editView.editPillNameView.pillNameTextField.text else { return }
            if self.changeBool.value == false || self.editCommonViewModel.timeViewModel.timeList.value.count == 0 || textField.count == 0 {
                self.unableNextButton()
            } else {
                self.enableNextButton()
            }
        case .day:
            if self.editCommonViewModel.timeViewModel.timeList.value.count != 0 && self.editCommonViewModel.dayViewModel.days.value != "" && self.editCommonViewModel.pillName.value != "" {
                self.enableNextButton()
            } else {
                self.unableNextButton()
            }
        case .period:
            if self.editCommonViewModel.timeViewModel.timeList.value.count != 0 && self.editCommonViewModel.periodViewModel.dayString.value != "" && self.editCommonViewModel.pillName.value != "" {
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
        DispatchQueue.main.async {
            self.editView.nextButton.backgroundColor = Color.mint
            self.editView.nextButton.setTitleColor(Color.white, for: .normal)
            self.editView.nextButton.isEnabled = true
        }
    }
    
    private func unableNextButton() {
        DispatchQueue.main.async {
            self.editView.nextButton.backgroundColor = Color.gray200
            self.editView.nextButton.setTitleColor(Color.gray500, for: .normal)
            self.editView.nextButton.isEnabled = false
        }
    }
}

extension EditViewController: UICollectionViewDelegate {}

extension EditViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return editCommonViewModel.timeViewModel.timeList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PillTimeCollectionViewCell.self)
        
        cell.updateCell(editCommonViewModel.timeViewModel, indexPath: indexPath)
        
        editCommonViewModel.changeTime = editCommonViewModel.timeViewModel.changeTimeList.value
        editCommonViewModel.time = editCommonViewModel.timeViewModel.timeList.value
        
        cell.viewModel.deleteCellClosure = { [weak self] in
            guard let self = self else { return }
            self.editCommonViewModel.timeViewModel.deleteCell(index: indexPath.row)
            self.editCommonViewModel.timeViewModel.deleteChangeTimeList(index: indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddPillFirstFooterView.reuseIdentifier, for: indexPath) as? AddPillFirstFooterView else { return UICollectionReusableView()}
        
        cell.viewModel.addCellClosure = { [weak self] in
            guard let self = self else { return }
            self.presentTimeView()
        }
        
        self.editCommonViewModel.timeViewModel.hideFooterView(button: &cell.addTimeButton.isHidden)
        
        return cell
    }
}

extension EditViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 40)
    }
}

extension EditViewController: UITextFieldDelegate { }

extension EditViewController: SendPillTimeDelegate, SendPillDaysDelegate, SendPillPeriodDelegate {
    func sendChangeTime(changeTime: String) {
        editCommonViewModel.timeViewModel.addChangeTime(pillTime: changeTime)
    }
    
    func snedPillTime(pillTime: String) {
        if pillTime.contains("오전") {
            let pill = pillTime.replacingOccurrences(of: "오전", with: "")
            editCommonViewModel.timeViewModel.addChangeTime(pillTime: "\(pill):00")
        }
        
        if pillTime.contains("오후") {
            let pill = pillTime.replacingOccurrences(of: "오후", with: "")
            
            editCommonViewModel.timeViewModel.addChangeTime(pillTime: "\(pill):00")
        }
        
        editCommonViewModel.timeViewModel.addPillTime(pillTime: pillTime)
    }
    
    func sendPillDays(pillDays: String) {
        editCommonViewModel.dayViewModel.days.value = pillDays.addSeparator()
        
        editCommonViewModel.scheduleDay.value = pillDays.addSeparator()
    }
    
    func sendPillPeriod(pillPeriod: String) {
        editCommonViewModel.periodViewModel.dayString.value = pillPeriod
        
        editCommonViewModel.scheduleSpecific.value = pillPeriod
    }
}
