//
//  TermsAndPolicesViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/07/27.
//

import UIKit

final class TermsAndPolicesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func popToSettingVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func personalInfo(_ sender: Any) {
        print("personalInfo")
    }
    
    @IBAction func serviceTerms(_ sender: Any) {
        print("serviceTerms")
    }
}
