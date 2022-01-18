//
//  MedicineTimeInfoCollectionViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/16.
//

import UIKit

class MedicineTimeInfoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - Properties
    var deleteCellClosure: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deleteButton.addTarget(self, action: #selector(deleteCellButtonClicked), for: .touchUpInside)
    }

    // MARK: - Functions
    
    func setTarget() {
        
    }
    @objc func deleteCellButtonClicked() {
        deleteCellClosure?()
    }
}
