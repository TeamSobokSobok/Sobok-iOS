//
//  WithdrawalViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/08/03.
//

import UIKit

protocol WitrhdrawalProtocol: StyleProtocol, DelegationProtocol {}

final class WithdrawalViewController: UIViewController, WitrhdrawalProtocol {
    @IBOutlet weak var reasonView: UIView!
    @IBOutlet weak var reasonTextView: UITextView!
    @IBOutlet weak var reasonTextCounter: UILabel!
    @IBOutlet weak var witrhdrawButton: UIButton!
    let accountWithdrawManager: AccountServiceable = AccountManager(apiService: APIManager(), environment: .development)
    private var reason: String = ""
    
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
        withdrawSobokSobok(reason)
        let completionViewController = WithdrawCompleteViewController.instanceFromNib()
        self.modalPresentationStyle = .fullScreen
        self.present(completionViewController, animated: true)
    }
}

extension WithdrawalViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if reasonTextView.hasText {
            textView.text.removeAll()
            textView.textColor = UIColor(cgColor: Color.black.cgColor)
        }
        else {
            textView.text = "적어주시는 여러분의 소중한 의견은 서비스 개선에\n큰 도움이 되어요:)"
            textView.textColor = UIColor(cgColor: Color.gray500.cgColor)
            reasonTextCounter.text = "0/2000"
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "적어주시는 여러분의 소중한 의견은 서비스 개선에큰 도움이 되어요:)"
            textView.textColor = UIColor(cgColor: Color.gray500.cgColor)
            reasonTextCounter.text = "0/2000"
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        reason = currentText
        guard let textRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: textRange, with: text)
        reasonTextCounter.text = "\(changedText.count)/2000"
        
        if changedText.count > 2000 {
            reasonTextView.deleteBackward()
            reasonTextCounter.text = "2000/2000"
        }
        
        return changedText.count < 2000
    }
}
