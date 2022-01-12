//
//  SendInfoListDataModel.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/11.
//

import UIKit

struct SendInfoListData {
    
    let medicineColorName: UIImage
    let medicineName: String
    let dateInfo: String
    let termInfo: String
    let timeInfo: String
    
    func addMedicineColor() -> UIImage? {
        return UIImage(named: medicineName)
    }
}

extension SendInfoListData {
    static let dummy: [SendInfoListData] = [
        SendInfoListData(medicineColorName: Image.circleRed!, medicineName: "비타민", dateInfo: "2022년 11월 30일 ~ 2023년 1월 11일", termInfo: "1주에 한 번", timeInfo: "오전 11:00, 오전 12:00, 오후 10:00"),
        SendInfoListData(medicineColorName: Image.circleBlue!, medicineName: "루테인", dateInfo: "2022년 11월 30일 ~ 2023년 1월 11일", termInfo: "1주에 한 번", timeInfo: "오전 11:00, 오전 12:00, 오후 10:00"),
        SendInfoListData(medicineColorName: Image.circlePink!, medicineName: "마그네슘", dateInfo: "2022년 11월 30일 ~ 2023년 1월 11일", termInfo: "1주에 한 번", timeInfo: "오전 11:00, 오전 12:00, 오후 10:00"),
        SendInfoListData(medicineColorName: Image.circleOrange!, medicineName: "오메가3", dateInfo: "2022년 11월 30일 ~ 2023년 1월 11일", termInfo: "1주에 한 번", timeInfo: "오전 11:00, 오전 12:00, 오후 10:00"),
        SendInfoListData(medicineColorName: Image.circlePurple!, medicineName: "칼슘", dateInfo: "2022년 11월 30일 ~ 2023년 1월 11일", termInfo: "1주에 한 번", timeInfo: "오전 11:00, 오전 12:00, 오후 10:00")
    ]
}
