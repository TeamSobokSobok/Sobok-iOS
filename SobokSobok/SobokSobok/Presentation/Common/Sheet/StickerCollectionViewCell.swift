//
//  StickerCollectionViewCell.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/14.
//

import UIKit

final class StickerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var stickerImageView: UIImageView!
    @IBOutlet weak var stickerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    public func configure() {
        
    }
}
