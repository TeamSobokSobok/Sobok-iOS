//
//  WeekSelectViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/16.
//

import UIKit

import EasyKit

protocol WeekSelectViewDelegate: AnyObject {
    func popupDissmissed()
}

final class WeekSelectViewController: BaseViewController {
    
    // MARK: - Properties
    let weekList: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var weekView: UIView!
    @IBOutlet weak var weekTableView: UITableView!
    weak var delegate: WeekSelectViewDelegate?
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        assignDelegation()
        registerXib()
    }
    
    // MARK: - Functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.delegate?.popupDissmissed()
        }
    }
    
    func setUI() {
        weekView.makeRounded(radius: 15)
    }
    
    func assignDelegation() {
        weekTableView.delegate = self
        weekTableView.dataSource = self
    }
    
    func registerXib() {
        weekTableView.register(WeekSelectTableViewCell.self)
    }
    
    @IBAction func touchUpToConfirmButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

// MARK: - Extensions
extension WeekSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WeekSelectTableViewCell else {return}
        cell.checkImage.isHidden.toggle()
    }
}

extension WeekSelectViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: WeekSelectTableViewCell.self)
        cell.weekLabel.text = weekList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
