//
//  RequestSharingViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/17.
//

import UIKit

final class RequestSharingViewController: BaseViewController {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func style() {
        // 네비게이션바 세팅
        title = "공유 요청하기"
        let closeButton = UIBarButtonItem(image: UIImage(named: "icClose48"), style: .plain, target: self, action: #selector(self.closeToShareView))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        
        // 키보드 커스텀
        searchTextField.returnKeyType = .search
    }
    
    // MARK: - Functions
    @objc private func closeToShareView() {
        navigationController?.popViewController(animated: true)
    }
}
