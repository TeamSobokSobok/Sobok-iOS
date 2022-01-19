//
//  UIViewController+Extension.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/19.
//

import UIKit

extension UIViewController {
    typealias CompletionHandler = ((UIAlertAction) -> Void)?
    typealias CancelHandler = ((UIAlertAction) -> Void)?
    
    func showAlert(title: String,
                   message: String,
                   completionTitle: String? = nil,
                   cancelTitle: String? = "취소",
                   completionHandler: CompletionHandler = nil) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: completionTitle, style: .default, handler: completionHandler)
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: nil)
        
        alertViewController.addAction(cancelAction, okAction)
        self.present(alertViewController, animated: true)
    }
}
