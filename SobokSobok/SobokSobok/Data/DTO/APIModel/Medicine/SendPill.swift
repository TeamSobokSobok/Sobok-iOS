//
//  SendPill.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/07.
//

import Foundation

struct SendPill: Codable {
    let pillName: [String]
    let start, end: String
    let takeInterval: Int
    let day: String?
    let specific: String
    let time: [String]
}
