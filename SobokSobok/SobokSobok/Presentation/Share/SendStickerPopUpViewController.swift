//
//  SendStickerPopUpViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/17.
//

import UIKit

final class SendStickerPopUpViewController: BaseViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var sendStickerPopUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Functions
    override func style() {
        sendStickerPopUpView.makeRounded(radius: 20)
    }
}
