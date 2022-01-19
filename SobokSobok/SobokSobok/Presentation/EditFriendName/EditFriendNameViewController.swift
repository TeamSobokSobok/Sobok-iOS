//
//  EditFriendNameViewController.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/20.
//

import UIKit

final class EditFriendNameViewController: BaseViewController {

    // MARK: - @IBOulet Properties
    @IBOutlet weak var nameTextFieldView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var warningTextLabel: UILabel!
    @IBOutlet weak var counterTextLabel: UILabel!
    
    // MARK: - Life View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func layout() {
        nameTextFieldView.makeRoundedWithBorder(radius: 12, color: Color.gray600.cgColor)
        warningTextLabel.isHidden = true
        counterTextLabel.isHidden = true
    }
}
