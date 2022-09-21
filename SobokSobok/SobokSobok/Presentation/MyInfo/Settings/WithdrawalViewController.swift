//
//  WithdrawalViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/08/03.
//

import UIKit

import Then
import SnapKit

protocol WitrhdrawalProtocol: StyleProtocol, DelegationProtocol {}

final class WithdrawalViewController: UIViewController, WitrhdrawalProtocol {
    @IBOutlet weak var reasonView: UIView!
    @IBOutlet weak var reasonTextView: UITextView!
    @IBOutlet weak var reasonTextCounter: UILabel!
    @IBOutlet weak var witrhdrawButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        assignDelegation()
    }
    
    func style () {
        reasonView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        witrhdrawButton.makeRounded(radius: 12)
    }
    
    func assignDelegation() {
        reasonTextView.delegate = self
    }

    @IBAction func backToSettingVC(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func confirmWitrhdrawal(_ sender: UIButton) {
        print("회원탈퇴")
    }
}

extension WithdrawalViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if(textView.textColor == UIColor(cgColor: Color.gray500.cgColor)) {
            textView.text = ""
            textView.textColor = UIColor(cgColor: Color.black.cgColor)
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        reasonTextCounter.text = "\(reasonTextView.text.count)/2000"
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "적어주시는 여러분의 소중한 의견은 서비스 개선에 큰 도움이 되어요:)"
            textView.textColor = UIColor(cgColor: Color.gray500.cgColor)
        }
    }
}
