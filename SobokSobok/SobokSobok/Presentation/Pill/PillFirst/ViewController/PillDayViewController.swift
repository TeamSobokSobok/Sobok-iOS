//
//  PillDayViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/05.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift

final class PillDayViewController: BaseViewController {

    let pillDayView = PillDayView()
    let disposeBag = DisposeBag()
    let weekObservable = Observable.of(["월", "화", "수", "목", "금", "토", "일"])
    let dataObservable = Observable.of("")
    private var pillTimeViewModel = PillTimeViewModel()
    var delegate: PopUpDelegate?
  
    override func loadView() {
        self.view = pillDayView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.delegate?.popupDismissed()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        weekObservable.bind(to: pillDayView.tableView.rx.items(cellIdentifier: "PillDayTableViewCell", cellType: PillDayTableViewCell.self)) {[weak self] row, element, cell in
            cell.dayLabel.text = element
            cell.checkImage.isHidden = true
        }
        .disposed(by: disposeBag)
        
        pillDayView.tableView.rx.itemSelected
          .subscribe(onNext: { [weak self] indexPath in
              guard let cell = self?.pillDayView.tableView.cellForRow(at: indexPath) as? PillDayTableViewCell else { return }
              
              
              
              cell.checkImage.isHidden.toggle()
              cell.isSelected.toggle()
              
              cell.dayLabel.text = self?.pillTimeViewModel.exampleString.value


          })
          .disposed(by: disposeBag)
        

        

        
        Observable.zip(pillDayView.tableView.rx.modelSelected(String.self),
                       pillDayView.tableView.rx.itemSelected)
            .bind { [weak self] (text, indexPath) in
                self?.pillDayView.tableView.deselectRow(at: indexPath, animated: true)
        
                    print(indexPath)
                
            }
            .disposed(by: disposeBag)
        
        
        pillDayView.tableView.rx.setDelegate(self)
        .disposed(by: disposeBag)

      
    }
    
    override func style() {
        super.style()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
    
    

    

}

extension PillDayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
