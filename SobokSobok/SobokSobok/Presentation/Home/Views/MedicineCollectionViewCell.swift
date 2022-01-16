//
//  MedicineCollectionViewCell.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/11.
//

import UIKit

public enum PillCellType {
    case main, share
}

final class MedicineCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    var pillCellType: PillCellType = .share {
        didSet {
            updateUI()
        }
    }
    
    var eatState: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - IBOutlets

    @IBOutlet weak var pillColorView: UIView!
    @IBOutlet weak var pillName: UILabel!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var emotionButton: UIButton!
    @IBOutlet weak var eatStateButton: UIButton!
    
    @IBOutlet weak var stickerStackView: UIStackView!
    @IBOutlet weak var stickerCountLabel: UILabel!
    
    // MARK: - Override
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        style()
        updateUI()
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
        checkButton.isHidden = false
        buttonStackView.isHidden = false
        pillName.setTypoStyle(typoStyle: .body2)
        pillColorView.makeRounded(radius: pillColorView.bounds.width / 2)
    }
    
    private func updateUI() {
        buttonStackView.isHidden = pillCellType == .main
        checkButton.isHidden = pillCellType == .share
        emotionButton.isHidden = !eatState
        eatStateButton.backgroundColor = eatState ? Color.lightMint : Color.gray150
        eatStateButton.setTitle(eatState ? "먹었어요" : "아직 안 먹었어요", for: .normal)
        eatStateButton.setTitleColor(eatState ? Color.darkMint : Color.gray600, for: .normal)
    }
}
