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
    
    private lazy var input = PillPeriodViewModel.Input(
        didEverydayButtonTap: addPillFirstView.everydayButton.rx.tap.asSignal(),
        didSpecificDayButtonTap: addPillFirstView.specificDayButton.rx.tap.asSignal(),
        didSpecificPeriodButtonTap: addPillFirstView.specificPeriodButton.rx.tap.asSignal(),
        selectPeriodButtonTap: addPillFirstView.specificView.backgroundButton.rx.tap.asSignal()
    )
   
    var specific: Specific?
    private lazy var output = viewModel.transform(input: input)
    private let disposeBag = DisposeBag()
    private let addPillFirstView = AddPillFirstView()
    private var pillTimeViewModel = PillTimeViewModel()
    private var viewModel = PillPeriodViewModel()
    
    override func loadView() {
        self.view = addPillFirstView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    override func style() {
        super.style()
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
    }
    
    private func presentView() {
        let medicineSpecificDayViewController = PillDayViewController.instanceFromNib()
        medicineSpecificDayViewController.modalPresentationStyle = .fullScreen
        medicineSpecificDayViewController.modalTransitionStyle = .crossDissolve
        self.present(medicineSpecificDayViewController, animated: true)
    }
    
    private func presentPeriodView() {
        let medicineSpecificDayViewController = PillPeriodViewController.instanceFromNib()
        medicineSpecificDayViewController.modalPresentationStyle = .overCurrentContext
        medicineSpecificDayViewController.modalTransitionStyle = .crossDissolve
        self.present(medicineSpecificDayViewController, animated: true)
    }
    
    private func bind() {
        // bind -> MainThread에서 실행되는 것을 보장
        // subscribe를 통해 CollectionView를 만들 수 있지만 구현에 따라 Background에서 실행될 수 있으므로 MainThread를 보장하지 않음
        // 위와 같은 방법을 해결하는 방법이 DispatchQueue.main.async와 .observeOn(MainScheduler.instance)가 있음
        // 하지만 자주 사용하지 않음 -> RxCocoa의 장점인 bind가 MainThread를 보장하기 때문에
        // 결론 bind를 사용한다면 Thread에 대한 고민 X
        pillTimeViewModel.pillTimeList.bind(to:
        addPillFirstView.collectionView.rx.items(cellIdentifier: "PillTimeCollectionViewCell", cellType: PillTimeCollectionViewCell.self))
        { index, text, cell in
            cell.timeLabel.text = text
        }
        .disposed(by: disposeBag)
        
        addPillFirstView.collectionView.rx.modelSelected(String.self)
            .subscribe(onNext: { text in
                print(text)
            })
            .disposed(by: disposeBag)
//
//        addPillFirstView.collectionView.rx.setDelegate(self)
//            .disposed(by: disposeBag)
        
        // 하나의 버튼을 공유해서 사용하는데 enum으로 분기처리를 해줌
        // 여기서 문제가 drive를 하면 코드가 돌아가질 않음
        // input, output 상관없이 bind를 쓴다면 먹힘
        // bind -> 값, 데이터 / drive -> UI
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
//                self.addPillFirstView.specificView.specificLabel.text = "무슨 요일에 먹나요?"
                self.pillTimeViewModel.exampleString.subscribe {
                    self.addPillFirstView.specificView.specificLabel.text = $0
                }
                .disposed(by: self.disposeBag)
                
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
    }
}
