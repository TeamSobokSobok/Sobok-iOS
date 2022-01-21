//
//  SendInfoCollectionViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

protocol EditCellDelegate: AnyObject {
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
    
    let pillColors: [String: UIImage] = [
        "1": Image.circleRed,
        "2": Image.circlePink,
        "3": Image.circleBlue,
        "4": Image.circlePurple,
        "5": Image.circleOrange
    ]
    var index: Int = 0
    weak var delegate: EditCellDelegate?
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
//        timeLabel.setTextWithLineHeight1(text: "오전 11:00, 오전 12:00, 오후 10:00,\n오후 11:00, 오후 12:00, 오후 10:00", lineHeight: 21)
    }
    
    @IBAction func touchUpToEditButton(_ sender: Any) {
        self.delegate?.selectedInfoButton(index: index)
    }
    
    // MARK: - Functions
    func setData(sendInfoData: PillData) {
        medicineColor.image = pillColors[sendInfoData.color]
        medicineNameLabel.text = sendInfoData.pillName
        let date = changeToDate(from: sendInfoData.startDate,
                                to: sendInfoData.endDate)
        dateLabel.text = date
        termLabel.text = sendInfoData.scheduleDay

        var scheduleString: String = ""
        let scheduleTime = sendInfoData.scheduleTime
        for (index, value) in scheduleTime.enumerated() {
            if index == scheduleTime.count - 1 {
                let time = changeToTime(time: value)
                scheduleString += "\(time)"
            } else if index % 3 == 2 {
                let time = changeToTime(time: value)
                scheduleString += "\(time)\n"
            } else {
                let time = changeToTime(time: value)
                scheduleString += "\(time), "
            }
        }
        timeLabel.text = scheduleString
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

extension SendInfoCollectionViewCell {
    func changeToDate(from start: String, to end: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        let start = dateFormatter.date(from: start)
        let end = dateFormatter.date(from: end)
        let startString: String = start?.toString(of: .calendar) ?? ""
        let endString: String = end?.toString(of: .calendar) ?? ""
        return "\(startString) ~ \(endString)"
    }

    func changeToTime(time: String) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm:ss"
        let time = timeFormatter.date(from: time)
        let gettedTime: String = time?.toString(of: .calendarTime) ?? ""
        return "\(gettedTime)"
    }
}
