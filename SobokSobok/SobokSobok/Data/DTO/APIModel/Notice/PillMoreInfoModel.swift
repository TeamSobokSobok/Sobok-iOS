//
//  PillMoreInfoModel.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/18.
//

import Foundation

// MARK: - PillMoreInfo
struct PillMoreInfo: Codable {
    let senderName: String
    let pillData: [PillData]?
}

// MARK: - PillData
struct PillData: Codable {
    let pillName, color, startDate, endDate: String
    let scheduleCycle, scheduleDay: String
    let scheduleSpecific: JSONNull?
    let scheduleTime: [String]
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
