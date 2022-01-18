//
//  TermSelectViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/18.
//

import UIKit

protocol TermSelectDelegate: AnyObject {
    func popupDismissed()
}

final class TermSelectViewController: BaseViewController {
    
    // MARK: - Properties
    private let dayList: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    private let periodList: [String] = ["일에 한 번", "주에 한 번", "달에 한 번"]
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var termView: UIView!
    @IBOutlet weak var termPickerView: UIPickerView!
    weak var delegate: TermSelectDelegate?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignDelegation()
    }
    
    // MARK: - Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.delegate?.popupDismissed()
        }
    }
    
    func assignDelegation() {
        termPickerView.delegate = self
        termPickerView.dataSource = self
    }
    
    override func style() {
        super.style()
        termView.makeRounded(radius: 15)
    }
    
    //
    @IBAction func touchUpToConfirmButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

// MARK: - Extensions
extension TermSelectViewController: UIPickerViewDelegate { }

extension TermSelectViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 127
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? dayList.count : periodList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        component == 0 ? dayList[row] : periodList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 28
    }
}
