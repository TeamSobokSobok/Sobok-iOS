//
//  MedicineInfoCollectionViewCell.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/16.
//

import UIKit

class MedicineInfoCollectionViewCell: UICollectionViewCell {

    // MARK: Property
    var deleteCellClosure: (() -> Void)?
    
    // MARK: @IBOutlets
    @IBOutlet weak var periodStackView: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet var pillNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor, borderWith: 1)
    }
    
    // 동적 셀 높이
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
    // MARK: IBAction
    @IBAction func deleteCellButtonClicked(_ sender: UIButton) {
        deleteCellClosure?()
    }
}
