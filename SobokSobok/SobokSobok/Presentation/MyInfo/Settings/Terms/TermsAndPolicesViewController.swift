//
//  TermsAndPolicesViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/07/27.
//

import UIKit

final class TermsAndPolicesViewController: UIViewController {

    public let personalInfoLink: String = "https://baejiann120.notion.site/4f976bca05bb40b49d618c745cc5b754"
    public let serviceTermsLink: String = "https://baejiann120.notion.site/77c1e0372c784f8399d1c588f2e89cef"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func openSafari(link: String) {
        guard let url = URL(string: link)
        else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func popToSettingVC(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func personalInfo(_ sender: UIButton) {
        openSafari(link: personalInfoLink)
    }
    
    @IBAction func serviceTerms(_ sender: UIButton) {
        openSafari(link: serviceTermsLink)
    }
}
