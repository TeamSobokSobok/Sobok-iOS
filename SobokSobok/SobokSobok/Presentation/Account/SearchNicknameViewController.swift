//
//  SearchNicknameViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/19.
//

import UIKit

final class SearchNicknameViewController: BaseViewController {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var searchNicknameTextField: UITextField!
    @IBOutlet weak var resultButton: UIButton!
    @IBOutlet weak var resultTextLabel: UILabel!
    @IBOutlet weak var noResultImageView: UIImageView!
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - @IBAction Properties
    
    @IBAction func touchUpToAddFriend(_ sender: Any) {
        print("적복이")
    }
}
