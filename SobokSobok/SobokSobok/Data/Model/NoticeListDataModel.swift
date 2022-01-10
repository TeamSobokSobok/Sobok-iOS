//
//  NoticeListDataModel.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/10.
//

import UIKit

struct NoticeListData {
    
    let noticeImageName: String
    let noticeTitle: String
    let noticeTime: String
    
    func makeNoticeImage() -> UIImage? {
        return UIImage(named: noticeImageName)
    }
}
