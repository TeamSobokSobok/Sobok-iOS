//
//  SettingViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/07/21.
//

import UIKit

final class SettingViewController: UIViewController {

    let email: String = "soboksobok.official@gmail.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func openSafari(link: String) {
        guard let url = URL(string: link)
        else { return }
        UIApplication.shared.open(url)
    }

    @IBAction func backToMyInfoVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func askEmail(_ sender: Any) {
        print("mailto:\(email)")
        let mailtoString = "mailto:sobok.official@gmail.com".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let mailtoUrl = URL(string: mailtoString!)!
        if UIApplication.shared.canOpenURL(mailtoUrl) {
                UIApplication.shared.open(mailtoUrl, options: [:])
        }    }
    
    @IBAction func termsAndPolicies(_ sender: Any) {
        navigationController?.pushViewController(TermsAndPolicesViewController.instanceFromNib(), animated: true)
    }
    
    @IBAction func openSourceLicense(_ sender: Any) {
        openSafari(link: "https://suave-lilac-075.notion.site/24cf548eac844195b6761770be57b3f1")
    }
    
    @IBAction func logOut(_ sender: Any) {
        print("logout")
    }
    
    @IBAction func withdraw(_ sender: Any) {
        print("withdraw")
    }
    
}
