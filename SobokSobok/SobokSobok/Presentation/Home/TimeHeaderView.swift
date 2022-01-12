//
//  TimeHeaderView.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/11.
//

import UIKit

final class TimeHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var editButtonStackView: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        editButtonStackView.isHidden = false
    }
}
