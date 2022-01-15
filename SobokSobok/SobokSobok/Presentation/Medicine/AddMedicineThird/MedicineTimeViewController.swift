//
//  MedicineTimeViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/15.
//

import UIKit

// MARK: Protocol
protocol TimePickerDismiss: AnyObject {
    func timePickerdismiss()
}

final class MedicineTimeViewController: BaseViewController {
    
    // MARK: Properties
    private var hourList: [String] = []
    private var minuteList: [String] = []
    weak var delegate: TimePickerDismiss?
    
    // MARK: @IBOutlets
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var timePickerHeight: NSLayoutConstraint!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var timePickerView: UIPickerView!
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assiginDelegate()
        initTimeData()
    }
    
    override func style() {
        super.style()
        confirmButton.makeRounded(radius: 12)
        mainView.makeRounded(radius: 20)
        timePickerHeight.constant = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.delegate?.timePickerdismiss()
        }
    }
    
    // MARK: Functions
    private func initTimeData() {
        for i in 0..<60 {
            var minute: String
            minute = i < 10 ? "0" + "\(i)" : "\(i)"
            minuteList.append(minute)
        }
        
        for i in 0..<24 {
            var hour: String
            hour =   i < 10 ? "0" + "\(i)" :  "\(i)"
            hourList.append(hour)
        }
    }
    
    private func assiginDelegate() {
        timePickerView.delegate = self
        timePickerView.dataSource = self
    }
    
    func sheetWithAnimation() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            // confirmButton의 오토레이아웃을 Bottom 기준으로 잡으면 애니메이션이 이상하게 먹히는 이슈
            // confirmButton의 오토레이아웃을 PickerView 기준으로 잡아 해결
            self?.timePickerHeight.constant = 305
            self?.view.layoutIfNeeded()
        }
    }
    
    // MARK: @IBAction
    @IBAction func confirmButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.timePickerdismiss()
        }
    }
}

// MARK: UIPickerViewDelegate
extension MedicineTimeViewController: UIPickerViewDelegate {
    
}

// MARK: UIPickerViewDataSource
extension MedicineTimeViewController: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 100
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        component == 0 ? hourList.count : minuteList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        component == 0 ? hourList[row] : minuteList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}
