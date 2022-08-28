//
//  AddUserViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/29.
//

import UIKit

protocol SelectFriendProtocol: StyleProtocol, BindProtocol, DelegationProtocol, TargetProtocol {}

final class SelectFriendViewController: UIViewController, SelectFriendProtocol {
    
    private let selectFriendViewModel: SelectFriendViewModel
    
    weak var popUpDelegate: PopUpDelegate?
    weak var sendNameDelegate: SendMemberDelegate?
    
    init(selectFriendViewModel: SelectFriendViewModel) {
        self.selectFriendViewModel = selectFriendViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let selectFriendView = SelectFriendView()
    
    override func loadView() {
        self.view = selectFriendView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        bind()
        assignDelegation()
        target()
    }
    
    func style() {
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
    
    func bind() {
        self.selectFriendViewModel.getMember()
        
        selectFriendViewModel.memberName.bind { _ in
            DispatchQueue.main.async {
                self.selectFriendView.pickerView.reloadAllComponents()
            }
        }
    }
    
    func target() {
        selectFriendView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    @objc func confirmButtonTapped() {
        self.dismiss(animated: true) { [weak self] in
            if let memberName = self?.selectFriendViewModel.memberName.value,
                let memberId = self?.selectFriendViewModel.memberId.value {
                self?.sendNameDelegate?.sendMember(name: memberName, id: memberId)
            }
            self?.popUpDelegate?.popupDismissed()
        }
    }
    
    func assignDelegation() {
        selectFriendView.pickerView.delegate = self
        selectFriendView.pickerView.dataSource = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.popUpDelegate?.popupDismissed()
        }
    }
}

extension SelectFriendViewController: UIPickerViewDelegate {}

extension SelectFriendViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        UserDefaults.standard.member.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return selectFriendViewModel.memberNameList.value[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectFriendViewModel.didSelectRowAt(pickerView, row: row, component: component)
    }
}
