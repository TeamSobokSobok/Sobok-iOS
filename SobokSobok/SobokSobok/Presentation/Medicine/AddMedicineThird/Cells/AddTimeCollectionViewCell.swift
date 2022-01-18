//
//  AddTimeCollectionViewCell.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/14.
//

import UIKit

final class AddTimeCollectionViewCell: UICollectionViewCell {

    // MARK: Property
    var deleteCellClosure: (() -> Void)?
    
    // MARK: @IBOutlet
    @IBOutlet weak var mainView: UIView!
    @IBOutlet var timeLabel: UILabel!
    
    // MARK: View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: Function
    private func setUI() {
        mainView.makeRoundedWithBorder(radius: 10, color: Color.darkMint.cgColor)
    }
    
    // MARK: @IBAction
    @IBAction func xButtonClicked(_ sender: UIButton) {
        deleteCellClosure?()
    }
}
