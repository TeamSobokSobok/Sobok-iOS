//
//  WithdrawalViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/08/03.
//

import UIKit

protocol WitrhdrawalProtocol: StyleProtocol {}

final class WithdrawalViewController: UIViewController, WitrhdrawalProtocol {

    @IBOutlet weak var reasonView: UIView!
    @IBOutlet weak var reasonTextView: UITextView!
    @IBOutlet weak var reasonTextCounter: UILabel!
    @IBOutlet weak var witrhdrawButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    func style () {
        reasonView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        witrhdrawButton.makeRounded(radius: 12)
    }
    
    @IBAction func backToSettingVC(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmWitrhdrawal(_ sender: UIButton) {
        print("회원탈퇴")
    }
}
