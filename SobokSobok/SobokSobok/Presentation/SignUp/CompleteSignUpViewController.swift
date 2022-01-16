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
        // 네비게이션 바
        title = "회원가입 완료"
    }
    
    @IBAction func touchUpToStart(_ sender: UIButton) {
        print("로그인")
    }
    
}
