//
//  PillPeriodViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/06.
//

import UIKit

final class PillPeriodViewController: BaseViewController {

    let pillPeriodView = PillPeriodView()
    let viewModel = PillPeriodViewModel()
    
    weak var popUpDelegate: PopUpDelegate?
    weak var sendPillPeriod: SendPillPeriodDelegate?
    
    override func loadView() {
        self.view = pillPeriodView
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
}

extension PillPeriodViewController {
    private func setAddTarget() {
        pillPeriodView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    @objc func confirmButtonTapped() {
        self.dismiss(animated: true) { [weak self] in
            if let pillPeriod = self?.viewModel.dayPeriod.value {
                self?.sendPillPeriod?.sendPillPeriod(pillPeriod: pillPeriod)
            }
            self?.popUpDelegate?.popupDismissed()
        }
    }
    
    private func assignDelegation() {
        pillPeriodView.pickerView.delegate = self
        pillPeriodView.pickerView.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.popUpDelegate?.popupDismissed()
        }
    }
}

// MARK: UIPickerViewDataSource
extension PillPeriodViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.numberOfRowsInComponent
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        viewModel.titleForRow(component, row)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.didSelectRowAt(pickerView, row: row, component: component)
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }

    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 150
    }
}
