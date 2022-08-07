//
//  SendPill.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/08.
//

struct SendPill: Codable {
    let pillName: [String]
    let start: String
    let end: String
    let takeInterval: Int
    let day: String?
    let specific: String?
    let time: [String]
}
