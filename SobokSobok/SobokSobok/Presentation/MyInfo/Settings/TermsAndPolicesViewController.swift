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

    private func openSafari(link: String) {
        guard let url = URL(string: link)
        else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func popToSettingVC(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func personalInfo(_ sender: Any) {
        openSafari(link: "https://suave-lilac-075.notion.site/6629bc1cbcb74d94a9d5d7563fe189ef")
    }
    
    @IBAction func serviceTerms(_ sender: Any) {
        openSafari(link: "https://suave-lilac-075.notion.site/33840908911044fe8651c1649706d7a1")
    }
}
