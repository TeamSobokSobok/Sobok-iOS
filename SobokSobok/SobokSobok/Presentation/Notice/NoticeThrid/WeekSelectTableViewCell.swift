//
//  WeekSelectTableViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/16.
//

import UIKit

class WeekSelectTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
