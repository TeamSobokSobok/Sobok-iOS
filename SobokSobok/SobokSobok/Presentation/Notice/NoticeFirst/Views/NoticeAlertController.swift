//
//  UIAlertController+Extension.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/02/23.
//

import UIKit

extension NoticeViewController {
    func makeAlert(title: String, message: String, accept: String, viewController: UIViewController? = nil, nextViewController: UIViewController? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: accept, style: .default) { _ in
            guard let nextViewController = nextViewController else { return }
            nextViewController.modalPresentationStyle = .fullScreen
            viewController?.present(nextViewController, animated: true) {
                UserDefaults.standard.setValue("accept", forKey: "accept")
            }
        }
        let refuseAction = UIAlertAction(title: "취소", style: .default) { _ in
            guard let nextViewController = nextViewController else { return }
            nextViewController.modalPresentationStyle = .fullScreen
            viewController?.present(nextViewController, animated: true) {
                UserDefaults.standard.setValue("refuse", forKey: "refuse")
            }
        }
        [refuseAction, acceptAction].forEach {
            alert.addAction($0)
        }
        viewController?.present(alert, animated: true, completion: completion)
    }

    func makeRefuseAlert(title: String, message: String, viewController: UIViewController? = nil, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "확인", style: .default) { _ in
            viewController?.dismiss(animated: true) {
                UserDefaults.standard.setValue("refuse", forKey: "refuse")
            }
        }
        alert.addAction(acceptAction)
        viewController?.present(alert, animated: true)
    }
}
