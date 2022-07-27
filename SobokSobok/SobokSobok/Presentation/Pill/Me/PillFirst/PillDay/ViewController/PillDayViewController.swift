//
//  PillDayViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/05.
//

import UIKit

import RxSwift
import RxCocoa

final class PillDayViewController: BaseViewController {

    private let pillDayView = PillDayView()
    private let viewModel = PillDayViewModel()
    weak var popUpDelegate: PopUpDelegate?
    weak var sendPillDays: SendPillDaysDelegate?
  
    override func loadView() {
        self.view = pillDayView
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        setAddTarget()
    }
    
    override func style() {
         super.style()
         view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
     }
    
    private func setAddTarget() {
        pillDayView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    @objc func confirmButtonTapped() {
        self.dismiss(animated: true) { [weak self] in
            if let pillDays = self?.viewModel.days.value {
                self?.sendPillDays?.sendPillDays(pillDays: pillDays)
            }
            self?.popUpDelegate?.popupDismissed()
        }
    }
}

extension PillDayViewController {
    private func assignDelegation() {
        pillDayView.tableView.delegate = self
        pillDayView.tableView.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.popUpDelegate?.popupDismissed()
        }
    }
}

extension PillDayViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PillDayTableViewCell.self)
    
        cell.selectionStyle = .none
        cell.updateCell(viewModel, indexPath: indexPath)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PillDayTableViewCell else { return }
        cell.checkImageIsHidden(viewModel, indexPath: indexPath)
    }
}
