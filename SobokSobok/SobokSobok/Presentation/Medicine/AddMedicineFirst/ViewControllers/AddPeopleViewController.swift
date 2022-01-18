//
//  AddPeopleViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/11.
//
import UIKit

// MARK: - Protocol
protocol AddPeopleViewDelegate: AnyObject {
    func popupDismissed()
}

protocol SendPeopleNameDelegate: AnyObject {
    func sendPeopleName(name: String)
}

final class AddPeopleViewController: BaseViewController {
   
    // MARK: - Properties
    // PickerView에서 선택한 이름을 저장해서 데이터전달 할 예정
    var selectedPeopleName = String()
    weak var delegate: AddPeopleViewDelegate?
    weak var sendDelegate: SendPeopleNameDelegate?
    // 임시 더미데이터
    var peopleNameList = ["태현", "승찬", "은희", "선영"]

    // MARK: - @IBOutlets
    @IBOutlet weak var addPeopleView: UIView!
    @IBOutlet weak var peopleNamePickerView: UIPickerView!
    @IBOutlet weak var confirmButton: UIButton!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        assignDelegate()
    }
    
    // MARK: - Functions
    
    // 뷰 터치 시 팝업 창 dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.delegate?.popupDismissed()
        }
    }
    
    private func setUI() {
        addPeopleView.makeRounded(radius: 15)
        confirmButton.makeRounded(radius: 10)
    }
    
    private func assignDelegate() {
        peopleNamePickerView.delegate = self
        peopleNamePickerView.dataSource = self
    }

    // MARK: - @IBActions
    @IBAction func touchConfirmButton(_ sender: UIButton) {
        self.dismiss(animated: true) { [weak self] in
            if let text = self?.selectedPeopleName {
                self?.sendDelegate?.sendPeopleName(name: text)
            }
            self?.delegate?.popupDismissed()
        }
    }
}

// MARK: PickerViewDelegate

extension AddPeopleViewController: UIPickerViewDelegate {
    
}

// MARK: PickerViewDataSource

extension AddPeopleViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return peopleNameList.count
       }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return peopleNameList[row]
        }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 42
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPeopleName = peopleNameList[row]
    }
}
