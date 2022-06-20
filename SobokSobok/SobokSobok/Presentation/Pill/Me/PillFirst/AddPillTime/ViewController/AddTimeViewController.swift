//
//  AddTimeViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/09.
//

import UIKit

final class AddTimeViewController: BaseViewController {

    let addTimeView = AddPillTimeView()
    let viewModel = AddTimeViewModel()
    weak var popUpDelegate: PopUpDelegate?
    weak var sendPillTime: SendPillTimeDelegate?
    
    override func loadView() {
        self.view = addTimeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        setAddTarget()
        bind()
    }
  
    override func style() {
        super.style()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
    
    private func bind() {
        viewModel.initTimeData()
    }
}

extension AddTimeViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
        }
    }
    
    private func setAddTarget() {
        addTimeView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }

    private func assignDelegation() {
        addTimeView.pickerView.delegate = self
        addTimeView.pickerView.dataSource = self
    }
    
    @objc func confirmButtonTapped() {
        self.dismiss(animated: true) { [weak self] in
            if let pillTime = self?.viewModel.pillTime.value {
                self?.sendPillTime?.snedPillTime(pillTime: pillTime)
            }
            self?.popUpDelegate?.popupDismissed()
        }
    }
}

// MARK: UIPickerViewDataSource
extension AddTimeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.numberOfRowsInComponent(component)
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
}
