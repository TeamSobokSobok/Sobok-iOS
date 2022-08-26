//
//  MyInfoTableViewCell.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/05/20.
//

import UIKit

class MyInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellOutline: UIView!
    @IBOutlet weak var pillColorImageView: UIImageView!
    @IBOutlet weak var pillNameLabel: UILabel!
    weak var myInfoViewDelegate: AccountDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        style()
    }
    
    @IBAction func pillDetailInfoButtonDidClicked(_ sender: UIButton) {
        myInfoViewDelegate?.presentEditView()
    }
}

extension MyInfoTableViewCell: StyleProtocol {
    func style() {
        cellOutline.makeRoundedWithBorder(radius: 12, color: Color.gray300.cgColor)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
    }
    
    func setData(name: String, image: String) {
        self.pillNameLabel.text = name
        self.pillColorImageView.image = UIImage(named: image)
    }
}
