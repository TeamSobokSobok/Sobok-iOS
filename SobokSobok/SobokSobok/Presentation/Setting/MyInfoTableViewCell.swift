//
//  MyInfoTableViewCell.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/05/20.
//

import UIKit
import CarPlay

class MyInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var cellOutline: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func style() {
        cellOutline.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
    }
}
