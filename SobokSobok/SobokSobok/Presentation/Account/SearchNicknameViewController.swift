//
//  SearchNicknameViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/19.
//

import UIKit

final class SearchNicknameViewController: BaseViewController {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var searchNicknameTextField: UITextField!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var noResultImageView: UIImageView!
        
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelgation()
        checkTextField()
    }

    override func style() {
        navigationController?.navigationBar.isHidden = true
        resultTextLabel.isHidden = true
        noResultImageView.isHidden = true
    }
    
    // MARK: - Functions
    private func checkTextField() {
        searchNicknameTextField.addTarget(self, action: #selector(self.limitTextCount), for: .editingChanged)
    }
    
    @objc private func limitTextCount() {
        if searchNicknameTextField.text?.count ?? 0 > 10 {
            searchNicknameTextField.deleteBackward()
        }
    }
    
    private func assignDelgation() {
        searchNicknameTextField.delegate = self
    }
    
    // 검색결과가 없을때
    private func setNoSearchResult() {
        resultTextLabel.isHidden = true
        noResultImageView.isHidden = false
    }
    
    // 검색결과가 있을때
    private func setYesSearchResult() {
        resultTextLabel.text = searchNicknameTextField.text ?? ""
        resultTextLabel.isHidden = false
        noResultImageView.isHidden = true
    }
        
    // MARK: - @IBAction Properties
    @IBAction func touchUpToClose(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func touchUpToAddFriend(_ sender: Any) {
        // 화면 전환
        let nextVC = SaveNicknameViewController.instanceFromNib()
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
                guard let data = data as? [SearchNicknameData] else { return }
                if data.isEmpty {
                    self.setNoSearchResult()
                } else {
                    self.setYesSearchResult()
                    // 데이터 전달 (다음 뷰에서 사용하기 위함)
                    SearchedUser.shared.searchedUserId = data[0].memberId
                    SearchedUser.shared.searchedUsername = data[0].memberName
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
