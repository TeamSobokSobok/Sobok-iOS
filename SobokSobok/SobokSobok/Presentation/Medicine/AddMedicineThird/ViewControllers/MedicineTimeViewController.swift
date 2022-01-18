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

protocol SendPillTimeDelegate: AnyObject {
    func sendTimeData(pillTime: String)
}

final class MedicineTimeViewController: BaseViewController {
    
    // MARK: Properties
    var hour = "1"
    var minute = "00"
    var dayNight = "오전"
    var pillTime = "오전 1:00"
    
    var hourList: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    var minuteList: [String] = []
    var morningList: [String] = ["오전", "오후"]
    weak var delegate: TimePickerDismiss?
    weak var sendTimeDelegate: SendPillTimeDelegate?
    
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
    }
    
    override func layout() {
        super.layout()
        timePickerHeight.constant = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.delegate?.timePickerdismiss()
        }
    }
    
    // MARK: Functions
    private func initTimeData() {
        for tmp in 0..<60 {
            var minute: String
            minute = tmp < 10 ? "0" + "\(tmp)" : "\(tmp)"
            minuteList.append(minute)
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
        self.dismiss(animated: true) { [weak self] in
            if let pillTime = self?.pillTime {
                self?.sendTimeDelegate?.sendTimeData(pillTime: pillTime)
            }
            self?.delegate?.timePickerdismiss()
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
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return morningList.count
        } else if component == 1 {
            return hourList.count
        } else {
            return minuteList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return morningList[row]
        } else if component == 1 {
            return hourList[row]
        } else {
            return minuteList[row]
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadAllComponents()
        if component == 0 {
            dayNight = morningList[row]
        } else if component == 1{
            hour = hourList[row]
        } else {
            minute = minuteList[row]
        }
        pillTime = dayNight + " " + hour + ":"  + minute
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}
