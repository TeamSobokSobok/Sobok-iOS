//
//  StickerCollectionViewCell.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/14.
//

import UIKit

import Kingfisher

final class StickerCollectionViewCell: UICollectionViewCell {

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
//        let url = URL(string: )
//        let data = try? Data(contentsOf: url!)
//        print(data!)
//        stickerImageView.image = UIImage(data: data!)
    }
}
