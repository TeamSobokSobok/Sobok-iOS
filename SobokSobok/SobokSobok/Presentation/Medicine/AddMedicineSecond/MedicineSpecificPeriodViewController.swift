//
//  MedicineSpecificPeriodViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/13.
//

import UIKit

protocol MedicineSpecificPeriodDelegate: AnyObject {
    func popupDismissed()
}

final class MedicineSpecificPeriodViewController: BaseViewController {
    
    // MARK: - Properties
    // PickerView의 담을 List
    private let dayList: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private let periodList: [String] = ["일에 한 번", "주에 한 번", "달에 한 번"]

    // MARK: - @IBOutlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dayPeriodPickerView: UIPickerView!
    weak var delegate: MedicineSpecificPeriodDelegate?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        assignDelegate()
    }
    
    // 뷰 터치 시 팝업 창 dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.delegate?.popupDismissed()
        }
    }
    
    // MARK: - Functions
    
    private func assignDelegate() {
        dayPeriodPickerView.dataSource = self
        dayPeriodPickerView.delegate = self
    }
    
    private func setUI() {
        mainView.makeRounded(radius: 15)
    }
}

// MARK: UIPickerViewDelegate

extension MedicineSpecificPeriodViewController: UIPickerViewDelegate {
    
}

// MARK: UIPickerViewDataSource
extension MedicineSpecificPeriodViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dayList.count
        } else {
            return periodList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return dayList[row]
        } else {
            return periodList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
}
