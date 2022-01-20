//
//  SendInfoCollectionViewCell.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

class SendInfoCollectionViewCell: UICollectionViewCell {
    
    let pillColors: [String: UIImage] = [
        "1": Image.circleRed,
        "2": Image.circlePink,
        "3": Image.circleBlue,
        "4": Image.circlePurple,
        "5": Image.circleOrange
    ]
    
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
    func setData(sendInfoData: PillData) {
        // 전달해야 하는 것: 약 색깔, 이름, 복용 기간, 간격, 시간
        medicineColor.image = pillColors[sendInfoData.color]    // 1️⃣ 약 색깔
        medicineNameLabel.text = sendInfoData.pillName  // 2️⃣ 약 이름
        let date = changeToDate(from: sendInfoData.startDate,
                                to: sendInfoData.endDate)
        dateLabel.text = date   // 3️⃣ 복용 기간
        termLabel.text = sendInfoData.scheduleDay   // 4️⃣ 복용 간격
        
        // 시간 배열 생성
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
        timeLabel.text = scheduleString // 5️⃣ 복용 시간

    }
    
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
