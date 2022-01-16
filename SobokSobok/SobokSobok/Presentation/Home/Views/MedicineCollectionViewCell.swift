//
//  MedicineCollectionViewCell.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/11.
//

import UIKit

final class MedicineCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var pillColorView: UIView!
    @IBOutlet weak var pillName: UILabel!
    @IBOutlet weak var stickerStackView: UIStackView!
    @IBOutlet weak var stickerCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
    private func style() {
        pillColorView.makeRounded(radius: pillColorView.bounds.width / 2)
        pillName.setTypoStyle(typoStyle: .body2)
        pillName.textColor = Color.black
    }
}
