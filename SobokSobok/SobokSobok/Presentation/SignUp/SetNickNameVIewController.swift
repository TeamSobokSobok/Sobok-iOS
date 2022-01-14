//
//  SetNickNameVIewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/14.
//

import UIKit

final class SetNickNameVIewController: BaseViewController {

    // MARK: @IBOutlet Properties
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var nickNameTextFieldView: UIView!
    @IBOutlet weak var nickNameTextField: UITextField!
    @IBOutlet weak var checkDuplicationButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var warningTextField: UILabel!
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func style() {
        warningTextField.isHidden = true
        signUpButton.isEnabled = false
        nickNameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
    }
    
    // MARK: @IBAction Properties
    @IBAction func touchUpToCheckDuplication(_ sender: Any) {
        print("닉네임중복확인")
    }
    
    @IBAction func touchUpToSignUp(_ sender: Any) {
        print("닉네임 : \(nickNameTextField.text ?? "" )")
    }
    
}
