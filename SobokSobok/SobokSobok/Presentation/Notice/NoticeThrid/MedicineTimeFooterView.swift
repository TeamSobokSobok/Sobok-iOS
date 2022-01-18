//
//  MedicineTimeFooterView.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/16.
//

import UIKit

class MedicineTimeFooterView: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var timePlusButton: UIButton!
    
    // MARK: - Properties
    var addCellClosure: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        timePlusButton.addTarget(self, action: #selector(addCellButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - Functions
    @objc func addCellButtonClicked() {
        addCellClosure?()
    }
}
