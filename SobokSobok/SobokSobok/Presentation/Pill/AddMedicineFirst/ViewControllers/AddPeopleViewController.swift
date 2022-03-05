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
    var tabName: String = ""
    var selectedPeopleName = String()
    weak var delegate: AddPeopleViewDelegate?
    weak var sendDelegate: SendPeopleNameDelegate?
    // 임시 더미데이터
    var peopleNameList : [String] = []
    var nameList : [String] = [] {
        didSet {
            peopleNamePickerView.reloadAllComponents()
        }
    }
    var groupItems = [Member]()

    // MARK: - @IBOutlets
    @IBOutlet weak var addPeopleView: UIView!
    @IBOutlet weak var peopleNamePickerView: UIPickerView!
    @IBOutlet weak var confirmButton: UIButton!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        assignDelegate()
        getGroupInfo()
    }
    
    // MARK: - Functions
    
    // 뷰 터치 시 팝업 창 dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.delegate?.popupDismissed()
        }
    }
    
    private func getFriendName(groupItems: [Member]) {
        for index in 0 ..< groupItems.count {
            tabName = groupItems[index].memberName
            peopleNameList.append(tabName)
        }
        nameList = peopleNameList
        }
    
    func updateData(data: Member) {
        peopleNameList.append(data.memberName)
    }
    
    private func setUI() {
        addPeopleView.layer.cornerRadius = 20
        addPeopleView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
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
           return nameList.count
       }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return nameList[row]
        }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 42
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPeopleName = nameList[row]
    }
}

extension AddPeopleViewController {

        private func getGroupInfo() {
            ShareAPI.shared.getGroupInfo { response in
                switch response {
                case .success(let data):
                    if let data = data as? [Member] {
                        self.groupItems = data
                    }
                    self.getFriendName(groupItems: self.groupItems)
                default:
                    return
                }
        }
    }
}
