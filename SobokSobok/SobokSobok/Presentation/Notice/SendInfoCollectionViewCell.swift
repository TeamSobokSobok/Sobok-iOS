//
//  SendInfoCollectionViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

class SendInfoCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var medicineColor: UIImageView!
    @IBOutlet weak var medicineNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    // MARK: - Functions
    func setData(sendInfoData: SendInfoListData) {
        medicineColor.image = sendInfoData.medicineColorName
        medicineNameLabel.text = sendInfoData.medicineName
        dateLabel.text = sendInfoData.dateInfo
        termLabel.text = sendInfoData.termInfo
        timeLabel.text = sendInfoData.timeInfo
    }
}
