//
//  CompleteSignUpViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/16.
//

import UIKit

final class CompleteSignUpViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func style() {
        title = "회원가입 완료"
        let backButton = UIBarButtonItem()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        backButton.title = ""
        backButton.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = .white
    }
}
