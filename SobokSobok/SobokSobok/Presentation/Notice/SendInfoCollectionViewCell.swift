//
//  SendInfoCollectionViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

protocol EditCellDelegate {
    func selectedInfoButton(index: Int)
}

class SendInfoCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlet Properties
    @IBOutlet weak var medicineColor: UIImageView!
    @IBOutlet weak var medicineNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    var index: Int = 0
    var delegate: EditCellDelegate?
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
    }
    
    @IBAction func touchUpToEditButton(_ sender: Any) {
        self.delegate?.selectedInfoButton(index: index)
    }
    
    // MARK: - Functions
    func setData(sendInfoData: SendInfoListData) {
        medicineColor.image = sendInfoData.medicineColorName
        medicineNameLabel.text = sendInfoData.medicineName
        dateLabel.text = sendInfoData.dateInfo
        termLabel.text = sendInfoData.termInfo
        timeLabel.text = sendInfoData.timeInfo
    }
    
    private func setUI() {
        timeLabel.setTextWithLineHeight1(text: "오전 11:00, 오전 12:00, 오후 10:00,\n오후 11:00, 오후 12:00, 오후 10:00", lineHeight: 21)
    }
}

extension UILabel {
    func setTextWithLineHeight1(text: String?, lineHeight: CGFloat) {
        if let text = text {
            let style = NSMutableParagraphStyle()
            style.maximumLineHeight = lineHeight
            style.minimumLineHeight = lineHeight
            
            let attributes: [NSAttributedString.Key: Any] = [
                .paragraphStyle: style
            ]
                
            let attrString = NSAttributedString(string: text,
                                                attributes: attributes)
            self.attributedText = attrString
        }
    }
}
