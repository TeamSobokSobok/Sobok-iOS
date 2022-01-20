//
//  StickerCollectionViewCell.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/14.
//

import UIKit

import Kingfisher

final class StickerCollectionViewCell: UICollectionViewCell {
    let bigStickers: [Int: UIImage] = [
        1: Image.bigSticker1,
        2: Image.bigSticker2,
        3: Image.bigSticker3,
        4: Image.bigSticker4,
        5: Image.bigSticker5,
        6: Image.bigSticker6
    ]

    @IBOutlet weak var stickerImageView: UIImageView!
    @IBOutlet weak var stickerTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    private func style() {
        stickerTitleLabel.isHidden = true
    }

    public func configure(stickers: Stickers) {
        print(stickers.stickerId, "전체스티커")
        stickerImageView.image = bigStickers[stickers.stickerId]
    }
}
