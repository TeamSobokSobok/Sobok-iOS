//
//  Date+Extension.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/18.
//

import Foundation

extension Date {
    enum FormatType {
        case full
        case year
        case day
        case month
        case second
        case time
        case calendar
        case calendarTime
        case calendarWithMonth
        case noticeDay
        
        var description: String {
            switch self {
            case .full:
                return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
            case .year:
                return "yyyy-MM-dd"
            case .day:
                return "M월 d일 EEEE"
            case .month:
                return "M월"
            case .second:
                return "HH:mm:ss"
            case .time:
                return "a h:mm"
            case .calendar:
                return "yyyy년 MM월 dd일"
            case .calendarTime:
                return "a HH:mm"
            case .calendarWithMonth:
                return "yyyy년 M월"
            case .noticeDay:
                return "yyyy.MM.dd"
            }
        }
    }
}

extension Date {
    
    func toString(of type: FormatType) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = type.description
        return dateFormatter.string(from: self)
    }
}

extension String {
    
    func toDate(to type: FormatType) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = type.description
        return dateFormatter.date(from: self)
    }
}
