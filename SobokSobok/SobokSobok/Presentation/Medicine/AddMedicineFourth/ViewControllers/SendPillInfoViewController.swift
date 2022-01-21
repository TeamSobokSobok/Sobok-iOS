//
//  SendPillInfoViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/19.
//

import UIKit

protocol SendPillInfoDelegate: AnyObject {
    func popDismiss()
}

final class SendPillInfoViewController: BaseViewController {

    weak var delegate: SendPillInfoDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.delegate?.popDismiss()
        }
    }
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        
    }
    
}
