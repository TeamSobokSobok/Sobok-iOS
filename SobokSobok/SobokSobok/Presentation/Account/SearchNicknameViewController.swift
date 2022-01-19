//
//  SearchNicknameViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/19.
//

import UIKit

final class SearchNicknameViewController: BaseViewController {

    // MARK: - @IBOutlet Properties
    private var searchedUser = SearchedUser.shared
    @IBOutlet weak var searchNicknameTextField: UITextField!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var noResultImageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelgation()
    }

    override func style() {
        navigationController?.navigationBar.isHidden = true
        resultTextLabel.isHidden = true
        noResultImageView.isHidden = true
    }
    
    // MARK: - Functions
    private func assignDelgation() {
        searchNicknameTextField.delegate = self
    }
    
    // 검색결과가 없을때
    private func setNoSearchResult() {
        resultTextLabel.text = searchNicknameTextField.text ?? ""
        resultTextLabel.isHidden = false
        noResultImageView.isHidden = true
    }
    
    // 검색결과가 있을때
    private func setYesSearchResult() {
        resultTextLabel.isHidden = true
        noResultImageView.isHidden = false
    }
    
    // MARK: - @IBAction Properties
    @IBAction func touchUpToClose(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func touchUpToAddFriend(_ sender: Any) {
        // 닉네임 저장 (다음 뷰에서 사용하기 위함)
        searchedUser.username = resultTextLabel.text
        
        // 화면 전환
        let nextVC = SaveNicknameViewController.instanceFromNib()
        nextVC.nickname = resultTextLabel.text ?? ""
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

extension SearchNicknameViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      searchNickname()
      searchNicknameTextField.resignFirstResponder()
    return true
  }
}

extension SearchNicknameViewController {
    func searchNickname() {
        guard let username = searchNicknameTextField.text else {
                   return
        }
        AddAccountAPI.shared.searchNickname(username: username, completion: {(result) in
            switch result {
            case .success(let data):
                print(data)
                if data == nil {
                    self.setNoSearchResult()
                } else {
                    self.setYesSearchResult()
                }
            case .requestErr(let message):
                print("requestErr", message)
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
