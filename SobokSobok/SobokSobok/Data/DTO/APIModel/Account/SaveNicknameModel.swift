//
//  SaveNicknameModel.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/20.
//

import Foundation

// MARK: - SaveNicknameData
struct SaveNicknameData: Codable {
    let sendGroupID, senderID: Int?
    let senderName: String?
    let memberID: Int?
    let memberName: String?
    let isSend: Bool?
    let isOkay: JSONNull?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case sendGroupID
        case senderID
        case senderName
        case memberID
        case memberName, isSend, isOkay, createdAt
    }
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
