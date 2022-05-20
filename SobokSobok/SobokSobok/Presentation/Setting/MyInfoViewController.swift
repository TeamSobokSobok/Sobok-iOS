//
//  MyInfoViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/05/20.
//

import UIKit

final class MyInfoViewController: BaseViewController {

    @IBOutlet weak var pillTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        registerXib()
    }
    
    private func assignDelegation() {
        pillTableView.delegate = self
        pillTableView.dataSource = self
    }
    
    private func registerXib() {
        pillTableView.register(MyInfoTableViewCell.self)
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
