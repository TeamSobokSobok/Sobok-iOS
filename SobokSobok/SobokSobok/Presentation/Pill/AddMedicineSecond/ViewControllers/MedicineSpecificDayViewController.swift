//
//  MedicineSpecificDayViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/13.
//

import UIKit

protocol MedicineViewDelegate: AnyObject {
    func popupDismissed()
}

protocol SendPillDayDelegate: AnyObject {
    func sendDay(day: String)
}

final class MedicineSpecificDayViewController: BaseViewController {
    
    // MARK: - Properties
    
    let dayList: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    var monday = ""
    var tuesday = ""
    var wednesday = ""
    var thursday = ""
    var friday = ""
    var saturday = ""
    var sunday = ""
    var days = String()
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dayTableView: UITableView!
    weak var delegate: MedicineViewDelegate?
    weak var sendDelegate: SendPillDayDelegate?
    
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
    @IBAction func comfirmButtonClicked(_ sender: UIButton) {
        self.dismiss(animated: true) { [weak self] in
            if let day = self?.days {
                self?.sendDelegate?.sendDay(day: day)
            }
            self?.delegate?.popupDismissed()
        }
    }
}

// MARK: UITableViewDelegate
extension MedicineSpecificDayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MedicineDayTableViewCell else { return }
        cell.vCheckImage.isHidden.toggle()
        cell.isSelected.toggle()
        switch indexPath.row {
        case 0:
            if cell.vCheckImage.isHidden {
                monday = ""
            } else {
                monday = dayList[0]
            }
        case 1:
            if cell.vCheckImage.isHidden {
                tuesday = ""
            } else {
                tuesday = dayList[1]
            }
        case 2:
            if cell.vCheckImage.isHidden {
                wednesday = ""
            } else {
                wednesday = dayList[2]
            }
        case 3:
            if cell.vCheckImage.isHidden {
                thursday = ""
            } else {
                thursday = dayList[3]
            }
        case 4:
            if cell.vCheckImage.isHidden {
                friday = ""
            } else {
                friday = dayList[4]
            }
        case 5:
            if cell.vCheckImage.isHidden {
                saturday = ""
            } else {
                saturday = dayList[5]
            }
        case 6:
            if cell.vCheckImage.isHidden {
                sunday = ""
            } else {
                sunday = dayList[6]
            }
        default:
            break
        }
        days = monday + tuesday + wednesday + thursday + friday + saturday + sunday
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
