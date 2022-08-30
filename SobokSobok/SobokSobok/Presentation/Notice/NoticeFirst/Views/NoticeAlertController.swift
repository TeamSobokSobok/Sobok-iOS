//
//  UIAlertController+Extension.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/02/23.
//

import UIKit

extension NoticeViewController {
    func makeAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.modalPresentationStyle = .fullScreen
            self.dismiss(animated: false)
        }
        let refuseAction = UIAlertAction(title: "취소", style: .default)
        [refuseAction, acceptAction].forEach { alert.addAction($0) }
        self.present(alert, animated: true, completion: completion)
    }

    func makeRefuseAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "확인", style: .cancel) { _ in
            self.dismiss(animated: false)
        }
        alert.addAction(acceptAction)
        self.present(alert, animated: true)
    }
}
