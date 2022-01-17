//
//  GenericResponse.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/17.
//

import Foundation

struct GenericResponse<T: Codable>: Codable {
    var status: Int
    var success: Bool
    var message: String?
    var data: T?
    
    enum CodingKeys: String, CodingKey {
        case message
        case success
        case data
        case status
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = (try? values.decode(String.self, forKey: .message)) ?? ""
        success = (try? values.decode(Bool.self, forKey: .success)) ?? false
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
        status = (try? values.decode(Int.self, forKey: .status)) ?? 0
    }
}
