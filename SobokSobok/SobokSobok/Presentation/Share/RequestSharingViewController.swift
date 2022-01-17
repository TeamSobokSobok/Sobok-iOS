//
//  RequestSharingViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/17.
//

import UIKit

final class RequestSharingViewController: BaseViewController {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var noResultImageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegate()
    }
    
    override func style() {
        setUI()
    }
    
    // MARK: - Functions
    @objc private func closeToShareView() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setUI() {
        // Navigation
        title = "공유 요청하기"
        
        // Button
        let closeButton = UIBarButtonItem(image: UIImage(named: "icClose48"), style: .plain, target: self, action: #selector(self.closeToShareView))
        closeButton.tintColor = .black
        navigationItem.leftBarButtonItem = closeButton
        
        // TextField
        noResultImageView.isHidden = true
        resultTextLabel.isHidden = true
        
        // Keyboard
        searchTextField.returnKeyType = .search
    }
    
    private func assignDelegate() {
        searchTextField.delegate = self
    }
    
    // MARK: - @IBAction
    @IBAction func touchUpToRequestSharing(_ sender: UIButton) {
        print("\(resultTextLabel.text ?? "")")
    }
}

// MARK: - Extensions
extension RequestSharingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField.hasText {
            resultTextLabel.text  = searchTextField.text ?? ""
            resultTextLabel.isHidden = false
            noResultImageView.isHidden = true
        } else {
            resultTextLabel.isHidden = true
            noResultImageView.isHidden = false
        }
        searchTextField.resignFirstResponder()
        return true
      }
}
