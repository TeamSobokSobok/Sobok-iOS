//
//  MyInfoViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/05/20.
//

import UIKit

final class MyInfoViewController: UIViewController, DelegationProtocol, StyleProtocol, LayoutProtocol, AccountDelegate {
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    lazy var pillTableView = UITableView()
    
    var editPillViewModel = EditCommonViewModel(addPillFirstViewModel: AddPillFirstViewModel(), timeViewModel: PillTimeViewModel(), dayViewModel: PillDayViewModel(), periodViewModel: PillPeriodViewModel())
    
    var userPillList: [UserPillList]? {
        didSet {
            self.pillTableView.reloadData()
        }
    }
    let myInfoManager: AccountServiceable = AccountManager(apiService: APIManager(), environment: .development)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assignDelegation()
        style()
        layout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUserPillInfoList()
    }

    func assignDelegation() {
        pillTableView.register(MyInfoPillCell.self)
        pillTableView.delegate = self
        pillTableView.dataSource = self
        pillTableView.rowHeight = 62
    }
    
    func style() {
        tabBarController?.tabBar.isHidden = true
        pillTableView.separatorStyle = .none
        nickNameLabel.text = UserDefaultsManager.userName
    }
    
    func layout() {
        view.addSubview(pillTableView)
        pillTableView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func presentEditView(pillId: Int) {
        let editViewController = EditViewController(
            viewModel: editPillViewModel
        )
        getUserDetailPillInfoList(pillId: pillId)
        self.navigationController?.pushViewController(editViewController, animated: true)
    }
    
    func transformString(string: String) -> String {
        let stringRange = string.index(string.startIndex, offsetBy: 0) ..< string.index(string.endIndex, offsetBy: -14)
      
        let changedString = string[stringRange]
        
        return String(changedString)
    }
    
    func transformStringToInt(_ array: [String]) -> [String] {
        
        var timeArray = [String]()
        var time = String()
        
        for string in array {
            let stringRange = string.index(string.startIndex, offsetBy: 0) ..< string.index(string.endIndex, offsetBy: -3)
          
            let changedArray = string[stringRange]
            
            var hour = String()
            var minute = String()
           
            let changedString = changedArray.map { String($0) }
  
            hour = "\(changedString[0])\(changedString[1])"
            minute = "\(changedString[3])\(changedString[4])"
            
            if Int(hour)! > 11 {
                print("오후 \(Int(hour)! - 12):\(minute)")
             
                time = "오후 \(Int(hour)! - 12):\(minute)"
                timeArray.append(time)

            } else {
                print("오전 \(hour):\(minute)")
                time = "오전 \(Int(hour)!):\(minute)"
                timeArray.append(time)
            }
        }
        
        return timeArray
    }

    // MARK: - @IBAction func
    
    @IBAction func showToolTip(_ sender: UIButton) {
    }
    
    @IBAction func popToMain(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func presentEditNicknameVC(_ sender: UIButton) {
        let editNicknameVC = UINavigationController(rootViewController: EditNicknameViewController.instanceFromNib())
        editNicknameVC.modalPresentationStyle = .fullScreen
        present(editNicknameVC, animated: true)
    }
    
    @IBAction func pushSettingVC(_ sender: UIButton) {
        navigationController?.pushViewController(SettingViewController.instanceFromNib(), animated: true)
    }
}

extension MyInfoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pillId = userPillList?[indexPath.row].id ?? 0
        editPillViewModel.pillId.value = pillId

        self.presentEditView(pillId: editPillViewModel.pillId.value)
    }
}

extension MyInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPillList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pillTableView.dequeueReusableCell(for: indexPath, cellType: MyInfoPillCell.self)
        cell.configure(with: userPillList?[indexPath.row])
        return cell
    }
}
