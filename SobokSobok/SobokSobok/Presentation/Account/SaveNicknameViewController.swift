//
//  SaveNicknameViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/19.
//

import UIKit

final class SaveNicknameViewController: BaseViewController {

    @IBOutlet weak var nicknameTextLabel: UILabel!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var warningTextLabel: UILabel!
    @IBOutlet weak var counterTextLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func style() {
        // 초기세팅
        searchView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        warningTextLabel.isHidden = true
        counterTextLabel.isHidden = true
        requestButton.isEnabled = false
    }
    
    @IBAction func touchUpToGoBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func touchUpToRequest(_ sender: Any) {
        print("request")
    }
}
