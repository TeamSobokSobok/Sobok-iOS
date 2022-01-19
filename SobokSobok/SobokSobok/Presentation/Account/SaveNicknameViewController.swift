//
//  SaveNicknameViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/19.
//

import UIKit

final class SaveNicknameViewController: BaseViewController {

    // MARK: - Properties
    private var nameCount: Int = 0
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var nicknameTextLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var warningTextLabel: UILabel!
    @IBOutlet weak var counterTextLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNickname()
    }
    
    override func style() {
        setWithNoneText()
        searchTextField.addTarget(self, action: #selector(self.checkTextField), for: .editingChanged)
    }
    
    // MARK: - Functions
    private func setNickname() {
        if let nickname = SearchedUser.shared.searchedUsername {
            nicknameTextLabel.text = nickname
            nicknameTextLabel.sizeToFit()
        }
    }
    
    @objc private func checkTextField() {
        // 글자수 카운트
        nameCount = searchTextField.text?.count ?? 0
        counterTextLabel.text = "\(nameCount) / 10"
        
        // 글자수 제한
        if nameCount > 10 {
            searchTextField.deleteBackward()
        }
        
        // 조건 분기처리
        if !searchTextField.hasText {
            setWithNoneText()
        } else if !checkIsIncludeSpecial(input: searchTextField.text ?? "") {
            warningTextLabel.text = "특수문자 입력은 불가능해요"
            setWarningVisible()
        } else if nameCount < 2 {
            warningTextLabel.text = "2자 이상 입력 가능해요"
            setWarningVisible()
        } else {
            setRequestEnable()
        }
    }
    
    // 글자가 없을 때
    private func setWithNoneText() {
        searchView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        counterTextLabel.isHidden = true
        warningTextLabel.isHidden = true
        requestButton.isEnabled = false
    }
    
    // 경고 세팅
    private func setWarningVisible() {
        searchView.makeRoundedWithBorder(radius: 12, color: Color.pillColorRed.cgColor)
        warningTextLabel.isHidden = false
        counterTextLabel.isHidden = false
        counterTextLabel.textColor = UIColor(cgColor: Color.pillColorRed.cgColor)
        requestButton.isEnabled = false
    }
    
    // 조건 맞을 때
    private func setRequestEnable() {
        searchView.makeRoundedWithBorder(radius: 12, color: Color.gray600.cgColor)
        warningTextLabel.isHidden = true
        counterTextLabel.textColor = UIColor(cgColor: Color.gray600.cgColor)
        requestButton.isEnabled = true
    }
    
    // 정규식 체크
    private func checkIsIncludeSpecial (input: String) -> Bool {
        let validNickName = "[A-Za-z가-힣0-9ㄱ-ㅎㅏ-ㅣ]{1,10}"
        let nickNameTest = NSPredicate(format: "SELF MATCHES %@", validNickName)
          return nickNameTest.evaluate(with: input)
    }
    
    // MARK: - @IBAction Properties
    @IBAction func touchUpToGoBack(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpToRequest(_ sender: UIButton) {
        print("request")
    }
}
