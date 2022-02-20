//
//  FooterCollectionViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/12.
//

import UIKit

final class FooterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    // MARK: - Functions
    private func setUI() {
        descriptionLabel.setTextWithLineHeight1(text: "전송받은 약이 내가 먹는 약과 다르다면\n수정해서 저장할 수 있어요", lineHeight: 21)
    }
}
