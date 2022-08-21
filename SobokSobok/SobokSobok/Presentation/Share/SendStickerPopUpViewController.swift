//
//  SendStickerPopUpViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/17.
//

import UIKit

protocol StickerPopUpDelegate: AnyObject {
    func sendStickerDidEnd(isLikedState: Bool, scheduleId: Int, likeScheduleId: Int, stickerId: Int)
}

final class SendStickerPopUpViewController: UIViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var sendStickerPopUpView: UIView!
    
    // MARK: - Properties
    var scheduleId: Int = 0
    weak var delegate: StickerPopUpDelegate?
    var isLikedState: Bool = false
    var likeScheduleId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Functions
    func style() {
        sendStickerPopUpView.makeRounded(radius: 20)
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendStickerButtonTapped(_ sender: UIButton) {
        postSticker(stickerId: sender.tag)
        self.dismiss(animated: true, completion: nil)
    }
    
    public func postSticker(stickerId: Int) {
        let userInfo: [AnyHashable : Any] = [
            "isLikedState": isLikedState,
            "scheduleId": scheduleId,
            "likeScheduleId": likeScheduleId,
            "stickerId": stickerId
        ]
        
        Notification.Name.sendSticker.post(object: nil, userInfo: userInfo)
    }
}
