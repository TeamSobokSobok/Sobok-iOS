//
//  SettingViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/07/21.
//

import UIKit

final class SettingViewController: UIViewController {

    private let email: String = "soboksobok.official@gmail.com"
    private let service: AccountServiceable = AccountManager(apiService: APIManager(), environment: .development)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func openSafari(link: String) {
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }

    @IBAction func backToMyInfoVC(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func askEmail(_ sender: UIButton) {
        print("mailto:\(email)")
        let mailtoString = "mailto:sobok.official@gmail.com".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let mailtoUrl = URL(string: mailtoString!)!
        if UIApplication.shared.canOpenURL(mailtoUrl) {
                UIApplication.shared.open(mailtoUrl, options: [:])
        }    }
    
    @IBAction func termsAndPolicies(_ sender: UIButton) {
        navigationController?.pushViewController(TermsAndPolicesViewController.instanceFromNib(), animated: true)
    }
    
    @IBAction func openSourceLicense(_ sender: UIButton) {
        openSafari(link: "https://suave-lilac-075.notion.site/24cf548eac844195b6761770be57b3f1")
    }
    
    @IBAction func logOut(_ sender: UIButton) {
        let logoutAlert = UIAlertController(title:"정말 로그아웃 하시나요?", message:"", preferredStyle: .alert)
        logoutAlert.addAction(UIAlertAction(title: "취소", style: .default, handler: {_ in print("취소")}))
        logoutAlert.addAction(UIAlertAction(title: "로그아웃", style: .destructive, handler: { [weak self] _ in
            self?.logout()
        }))
        present(logoutAlert, animated: true)
    }
    
    @IBAction func withdraw(_ sender: UIButton) {
        navigationController?.pushViewController(WithdrawalViewController.instanceFromNib(), animated: true)
    }
}

extension SettingViewController {
    private func logout() {
        Task {
            do {
                let result = try await service.logout()
                UserDefaultsManager.autoLogin = false
                self.transitionToSignInView()
            }
        }
    }
    
    private func transitionToSignInView() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = SocialSignInViewController()
        sceneDelegate?.window?.makeKeyAndVisible()
    }
}
