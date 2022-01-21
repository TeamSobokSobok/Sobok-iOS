//
//  SendStickerPopUpViewController.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/17.
//

import UIKit

protocol StickerPopUpDelegate: AnyObject {
    func sendStickerDidEnd()
}

final class SendStickerPopUpViewController: BaseViewController {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var sendStickerPopUpView: UIView!
    
    // MARK: - Properties
    var scheduleId: Int = 0
    weak var delegate: StickerPopUpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Functions
    override func style() {
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
        StickerAPI.shared.postSticker(scheduleId: self.scheduleId, stickerId: stickerId) { response in
            switch response {
            case .success(_):
                self.delegate?.sendStickerDidEnd()
            default:
                return
            }
        }
    }
}
