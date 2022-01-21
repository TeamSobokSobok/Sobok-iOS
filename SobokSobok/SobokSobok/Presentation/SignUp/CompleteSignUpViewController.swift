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
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func touchUpToStart(_ sender: UIButton) {
        print("로그인")
    }
    
}
