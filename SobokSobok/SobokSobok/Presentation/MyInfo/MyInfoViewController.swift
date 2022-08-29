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

extension MyInfoViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pillId = userPillList?[indexPath.row].id ?? 0
        self.presentEditView(pillId: pillId)
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
