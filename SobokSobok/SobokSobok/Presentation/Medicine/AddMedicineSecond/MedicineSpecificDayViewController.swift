//
//  MedicineSpecificDayViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/13.
//

import UIKit

import EasyKit

protocol MedicineViewDelegate: AnyObject {
    func popupDismissed()
}

final class MedicineSpecificDayViewController: BaseViewController {
    
    // MARK: - Properties
    
    let dayList: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dayTableView: UITableView!
    weak var delegate: MedicineViewDelegate?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        setUI()
    }
    
    // MARK: - Functions
    // 뷰 터치 시 팝업 창 dismiss
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.delegate?.popupDismissed()
        }
    }
    
    private func setUI() {
        mainView.makeRounded(radius: 15)
    }
    
    private func setTableView() {
        dayTableView.register(MedicineDayTableViewCell.self)
        dayTableView.dataSource = self
        dayTableView.delegate = self
    }
}

// MARK: UITableViewDelegate
extension MedicineSpecificDayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? MedicineDayTableViewCell else { return }
        
        cell.vCheckImage.isHidden = !cell.vCheckImage.isHidden
    }
}

// MARK: UITableViewDataSource
extension MedicineSpecificDayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MedicineDayTableViewCell.self)
        
        cell.dayLabel.text = dayList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
