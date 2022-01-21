//
//  PillTimeInfoCollectionViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/18.
//

import UIKit

final class PillTimeInfoCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - Properties
    var deleteCellClosure: (() -> Void)?
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setTarget()
    }
    
    // MARK: - Functions
    func setTarget() {
        deleteButton.addTarget(self, action: #selector(deleteCellButtonClicked), for: .touchUpInside)
    }
    
    @objc func deleteCellButtonClicked() {
        deleteCellClosure?()
    }
}
