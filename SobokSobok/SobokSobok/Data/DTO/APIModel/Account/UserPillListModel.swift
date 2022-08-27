//
//  UserPillListModel.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/26.
//

import UIKit

struct UserPillList: Codable {
    let id: Int
    let color: String
    let pillName: String
}

struct DetailPillList: Codable {
    let pillId: Int
    let pillName: String
    let color: String
    let startDate: String
    let endDate: String
    let takeInterval: Int
    let scheduleDay: String?
    let scheduleSpecific: String?
    let time: [String]
}
