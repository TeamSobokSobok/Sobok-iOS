//
//  SendStickerPopUpViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/17.
//

import UIKit

final class SendStickerPopUpViewController: UIViewController {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var sendStickerPopUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - Functions
    private func setUI() {
        sendStickerPopUpView.cornerRadius = 20
    }
}
