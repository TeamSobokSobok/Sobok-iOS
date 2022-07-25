//
//  MyInfoViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/05/20.
//

import UIKit

final class MyInfoViewController: UIViewController {

    @IBOutlet weak var pillTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        registerXib()
    }
    
    private func assignDelegation() {
        pillTableView.dataSource = self
        pillTableView.delegate = self
    }
    
    private func registerXib() {
        pillTableView.register(MyInfoTableViewCell.self)
        pillTableView.alwaysBounceVertical = false
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
}

extension MyInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pillTableView.dequeueReusableCell(for: indexPath, cellType: MyInfoTableViewCell.self)
        return cell
    }
}
