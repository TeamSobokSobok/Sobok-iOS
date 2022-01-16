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
    var pillCellType: PillCellType = .main {
        didSet {
            updateUI()
        }
    }
    
    var eatState: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    var isEdit: Bool = false {
        didSet {
            updateUI()
        }
    }
    
    var isChecked: Bool = false {
        didSet {
            isChecked ?
            checkButton.setImage(Image.icCheckSelect56, for: .normal) :
            checkButton.setImage(Image.icCheckUnselect56, for: .normal)
        }
    }
    
    var stickerClosure: (() -> Void)?
    var editClosure: (() -> Void)?
    
    // MARK: - IBOutlets

    @IBOutlet weak var pillColorView: UIView!
    @IBOutlet weak var pillName: UILabel!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
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
    
    // MARK: - Functions
    
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
        editButton.isHidden = !isEdit
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
        editClosure?()
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        isChecked.toggle()
    }
    
    @IBAction func stickerButtonTapped(_ sender: AnyObject) {
        stickerClosure?()
    }
}
