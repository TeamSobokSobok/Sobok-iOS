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
    }
    
    override func style() {
        // 초기세팅
        searchView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        warningTextLabel.isHidden = true
        counterTextLabel.isHidden = true
        requestButton.isEnabled = false
        
        // selector
        searchTextField.addTarget(self, action: #selector(self.checkTextField), for: .editingChanged)
    }
    
    // MARK: - Functions
    @objc private func checkTextField() {
        // 글자여부 분기처리
        if searchTextField.hasText {
            setSearchTextFieldAvailable()
        } else {
            setSearchTextFieldUnavailable()
        }
        
        // 글자수 제한
        if searchTextField.text?.count ?? 0 > 10 {
                searchTextField.deleteBackward()
        }
        
        // 글자수 카운트
        nameCount = searchTextField.text?.count ?? 0
        counterTextLabel.text = "\(nameCount) / 10"
    }
    
    // 글자 있을 때와 없을때 세팅
    private func setSearchTextFieldAvailable () {
        searchView.makeRoundedWithBorder(radius: 12, color: Color.gray600.cgColor)
        counterTextLabel.isHidden = false
    }
    private func setSearchTextFieldUnavailable () {
        searchView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        counterTextLabel.isHidden = true
    }
    
    // MARK: - @IBAction Properties
    @IBAction func touchUpToGoBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpToRequest(_ sender: Any) {
        print("request")
    }
}
