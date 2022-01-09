//
//  AddMedicineSheet.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/09.
//

import UIKit
import EasyKit

class AddMedicineSheet: UIViewController {

    // MARK: Properties
    
    let medicineImage = [Image.icMyFillPlus, Image.icFillSend]
    let medicineText = ["내 약 추가", "다른 사람에게 약 전송"]
 
    // MARK: @IBOutlet Properties
    
    @IBOutlet var medicineTableView: UITableView!
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
    }
    
    // MARK: - Functions
    
    func assignDelegation() {
        medicineTableView.dataSource = self
        medicineTableView.delegate = self
        medicineTableView.register(AddMedicineTableViewCell.self)
    }
}

// MARK: - UITableViewDelegate
extension AddMedicineSheet: UITableViewDelegate {
    
}

// MARK: - UITableViewDataSource

extension AddMedicineSheet: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicineImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let medicineCell = medicineTableView.dequeueReusableCell(for: indexPath, cellType: AddMedicineTableViewCell.self)
        // 셀이 선택 되었을 때 배경색 변하지 않게
        medicineCell.selectionStyle = .none
        
        medicineCell.medicineImageView.image = medicineImage[indexPath.row]
        medicineCell.addMedicineLabel.text = medicineText[indexPath.row]
        
        return medicineCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 추후에 나머지 뷰 만들면 연결 예정
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
}
