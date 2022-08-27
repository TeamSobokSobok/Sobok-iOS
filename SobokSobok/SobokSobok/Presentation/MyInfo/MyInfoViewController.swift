//
//  MyInfoViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/05/20.
//

import UIKit

final class MyInfoViewController: UIViewController, DelegationProtocol, StyleProtocol, AccountDelegate {
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var pillTableView: UITableView!
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
        getUserPillInfoList()
    }
    
    func assignDelegation() {
        pillTableView.register(MyInfoTableViewCell.self)
        pillTableView.delegate = self
        pillTableView.dataSource = self
    }
    
    func style() {
        tabBarController?.tabBar.isHidden = true
    }
    
    func presentEditView(pillId: Int) {
        let editViewController = EditViewController(
            viewModel: EditCommonViewModel(
                addPillFirstViewModel: AddPillFirstViewModel(),
                timeViewModel: PillTimeViewModel(),
                dayViewModel: PillDayViewModel(),
                periodViewModel: PillPeriodViewModel()
            )
        )

        self.navigationController?.pushViewController(editViewController, animated: true)
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

extension MyInfoViewController: UITableViewDelegate {}

extension MyInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPillList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pillTableView.dequeueReusableCell(for: indexPath, cellType: MyInfoTableViewCell.self)
        let pillColor = userPillList?[indexPath.row].color.colorTypeToImageName() ?? ""
        let pillName = userPillList?[indexPath.row].pillName ?? ""
        
        cell.setData(name: pillName, image: pillColor)
        cell.myInfoViewDelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click")
        self.presentEditView(pillId: userPillList?[indexPath.row].id ?? 00)
        print(userPillList?[indexPath.row].id ?? 00)
    }
}
