//
//  UIAlertController+Extension.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/02/23.
//

import UIKit

public func makeAlert(title: String, message: String, accept: String, vc: UIViewController, nextVC: UIViewController? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let acceptAction = UIAlertAction(title: accept, style: .default) { _ in
        guard let nextViewController = nextVC else { return }
        nextViewController.modalPresentationStyle = .fullScreen
        vc.present(nextViewController, animated: true)
    }
    let refuseAction = UIAlertAction(title: "취소", style: .default, handler: nil)
    [refuseAction, acceptAction].forEach {
        alert.addAction($0)
    }
    vc.present(alert, animated: true)
}
