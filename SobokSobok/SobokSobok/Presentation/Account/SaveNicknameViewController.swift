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
    private var isRight: Bool = false
    
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
        searchTextField.addTarget(self, action: #selector(self.completeTyping), for: .editingDidEnd)
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
            isRight = false
            warningTextLabel.text = "특수문자 입력은 불가능해요"
            setWarningVisible()
        } else if nameCount < 2 {
            isRight = false
            warningTextLabel.text = "2자 이상 입력 가능해요"
            setWarningVisible()
        } else {
            isRight = true
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
    
    // 조건 맞지 않을 때
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
    
    // 조건에 맞는 타이핑 완료했을 때
    @objc private func completeTyping() {
        if isRight {
            searchTextField.resignFirstResponder()
            searchView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
            counterTextLabel.isHidden = true
        }
    }
    
    // 토스트 메세지
    private func showToast(message: String) {
        var toastLabel = UILabel()
        // 토스트 위치
        toastLabel = UILabel(frame: CGRect(x: 20,
                                           y: self.view.frame.size.height - 95,
                                           width: self.view.frame.size.width - 40,
                                           height: 47))
        // 토스트 색
        toastLabel.backgroundColor = Color.black
        toastLabel.textColor = Color.white
        // 토스트 값
        toastLabel.text = message
        // 토스트 모양
        toastLabel.textAlignment = .center
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true
        // 토스트 애니메이션
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 1.5, delay: 0.1,
                       options: .curveEaseIn, animations: { toastLabel.alpha = 0.0 },
                       completion: {_ in toastLabel.removeFromSuperview() })
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
        saveNickname()
    }
}

extension SaveNicknameViewController {
    func saveNickname() {
        guard let memberID = SearchedUser.shared.searchedUserId else { return }
        guard let savedName = self.searchTextField.text else { return }
        
        AddAccountAPI.shared.saveNickname(memberId: memberID, memberName: savedName, completion: {(result) in
            switch result {
            case .success(let data):
                print(data)
            case .requestErr(_):
                self.showToast(message: "이미 추가된 사람이에요")
            case .pathErr:
                print(".pathErr")
            case .serverErr:
                print("serverErr")
            case .networkFail:
                print("networkFail")
            }
        })
    }
}
