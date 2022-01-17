//
//  RequestSharingViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/17.
//

import UIKit

final class RequestSharingViewController: BaseViewController {

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func style() {
        // 네비게이션바 세팅
        title = "공유 요청하기"
        let closeButton = UIBarButtonItem(image: UIImage(named: "icClose48"), style: .plain, target: self, action: #selector(self.closeToShareView))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
    }
    
    // MARK: - Functions
    @objc private func closeToShareView() {
        navigationController?.popViewController(animated: true)
    }
}
