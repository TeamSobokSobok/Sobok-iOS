//
//  SettingViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/07/21.
//

import UIKit

final class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backToMyInfoVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func askEmail(_ sender: Any) {
        print("askEmail")
    }
    
    @IBAction func termsAndPolicies(_ sender: Any) {
        navigationController?.pushViewController(TermsAndPolicesViewController.instanceFromNib(), animated: true)
    }
    
    @IBAction func openSourceLicense(_ sender: Any) {
        print("openSourceLicense")
    }
    
    @IBAction func logOut(_ sender: Any) {
        print("logout")
    }
    
    @IBAction func withdraw(_ sender: Any) {
        print("withdraw")
    }
    
}
