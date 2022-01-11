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

extension NoticeListData {
    static let dummy: [NoticeListData] = [
        NoticeListData(noticeImageName: "icCalendarAlarmMint", noticeTitle: "지민지민님이 캘린더 공유를 요청했어요", noticeTime: "오후 12:35"),
        NoticeListData(noticeImageName: "icFillAlarmMint", noticeTitle: "수현이님이 복약 정보를 전송했어요", noticeTime: "오전 10:40"),
        NoticeListData(noticeImageName: "icFillAlarmGray", noticeTitle: "효영님의 약 전송을 거절했어요", noticeTime: "오전 8:21"),
        NoticeListData(noticeImageName: "icFillAlarmMint", noticeTitle: "나는야효영이라네로를님이 복약 정보를 전송했어요", noticeTime: "2022.01.06"),
        NoticeListData(noticeImageName: "icFillAlarmGray", noticeTitle: "나는야효영이라네로를님의 약 전송을 거절했어요", noticeTime: "2022.01.06")
    ]
}
