//
//  AddPillFirstViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/01.
//

import UIKit

import RxSwift
import RxCocoa

final class AddPillFirstViewController: BaseViewController {
    
    private lazy var input = AddPillFirstViewModel.Input(
        didEverydayButtonTap: addPillFirstView.everydayButton.rx.tap.asSignal(),
        didSpecificDayButtonTap: addPillFirstView.specificDayButton.rx.tap.asSignal(),
        didSpecificPeriodButtonTap: addPillFirstView.specificPeriodButton.rx.tap.asSignal(),
        selectPeriodButtonTap: addPillFirstView.specificView.backgroundButton.rx.tap.asSignal()
    )
    
    var specific: Specific?
    private lazy var output = viewModel.transform(input: input)
    private let disposeBag = DisposeBag()
    private let addPillFirstView = AddPillFirstView()
    private var pillDayViewModel = PillDayViewModel()
    private var viewModel = AddPillFirstViewModel()
    private var addPillTimeViewModel = AddTimeViewModel()
    private var pillTimeViewModel = PillTimeViewModel()
    private var pillPeriodViewModel = PillPeriodViewModel()
    
    override func loadView() {
        self.view = addPillFirstView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        bind()
    }
    
    override func style() {
        super.style()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
    }
    
    private func bind() {
        // bind -> MainThread에서 실행되는 것을 보장
        // subscribe를 통해 CollectionView를 만들 수 있지만 구현에 따라 Background에서 실행될 수 있으므로 MainThread를 보장하지 않음
        // 위와 같은 방법을 해결하는 방법이 DispatchQueue.main.async와 .observeOn(MainScheduler.instance)가 있음
        // 하지만 자주 사용하지 않음 -> RxCocoa의 장점인 bind가 MainThread를 보장하기 때문에
        // 결론 bind를 사용한다면 Thread에 대한 고민 X
        
        // 하나의 버튼을 공유해서 사용하는데 enum으로 분기처리를 해줌
        // 여기서 문제가 drive를 하면 코드가 돌아가질 않음
        // input, output 상관없이 bind를 쓴다면 먹힘
        // bind -> 값, 데이터 / drive -> UI
        addPillFirstView.everydayButton.rx.tap.bind {
            self.addPillFirstView.everydayButton.isSelected.toggle()
            if self.addPillFirstView.everydayButton.isSelected {
                self.enableNextButton()
            } else {
                self.unableNextButton()
            }
        }
        .disposed(by: disposeBag)
        
        addPillFirstView.specificDayButton.rx.tap
            .bind {
                self.pillPeriodViewModel.dayPeriod.value = "며칠 간격으로 먹나요?"
                self.unableNextButton()
            }
            .disposed(by: disposeBag)
        
        addPillFirstView.specificPeriodButton.rx.tap
            .bind {
                self.pillDayViewModel.days.value = "무슨 요일에 먹나요?"
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
    
        // drive에서 UI업데이트를 하는데 이 방식이 맞는지 모르겠음
        // specificLabel의 Text -> Observable로 바꿀 예정
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
        
        // 보통 프로퍼티의 속성 감시자 didSet을 사용해서 UI를 업데이트 해주는데 MVVM, 따로 만든 Helper에서는 프로퍼티마다 didSet이 동작을 함
        // 따라서 UI업데이트 시 bind를 통해 UI업데이트를 하면 됨 
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
        
        pillPeriodViewModel.example.bind { [weak self] (text) in
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
    }
    
    private func unableNextButton() {
        addPillFirstView.nextButton.backgroundColor = Color.gray200
        addPillFirstView.nextButton.setTitleColor(Color.gray500, for: .normal)
        addPillFirstView.nextButton.isEnabled = false
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
}

extension AddPillFirstViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pillTimeViewModel.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
  
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: PillTimeCollectionViewCell.self)
        
        // cell의 UI업데이트
        cell.updateCell(pillTimeViewModel, indexPath: indexPath)
        
        // XButton 클릭 시 지움
        cell.viewModel.deleteCellClosure = { [weak self] in
            guard let self = self else { return }
            self.pillTimeViewModel.deleteCell(index: indexPath.row)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddPillFirstFooterView.reuseIdentifier, for: indexPath) as? AddPillFirstFooterView else { return UICollectionReusableView()}
       
        cell.viewModel.addCellClosure = { [weak self] in
            guard let self = self else { return }
            self.presentTimeView()
        }
        
        self.pillTimeViewModel.hideFooterView(button: &cell.addTimeButton.isHidden, stackView: &cell.horizontalStackView.isHidden)
        
        return cell
    }
}

extension AddPillFirstViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 40, height: 54)
    }
}

extension AddPillFirstViewController: SendPillTimeDelegate, SendPillDaysDelegate, SendPillPeriodDelegate {
    func snedPillTime(pillTime: String) {
        pillTimeViewModel.addPillTime(pillTime: pillTime)
    }
    
    func sendPillDays(pillDays: String) {
        pillDayViewModel.days.value = pillDays.addSeparator()
    }
    
    func sendPillPeriod(pillPeriod: String) {
        pillPeriodViewModel.example.value = pillPeriod
    }
}
