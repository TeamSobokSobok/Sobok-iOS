//
//  AcceptPillModel.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/08/07.
//

import Foundation

struct AcceptPill: Decodable {
    var status: Int
    var success: Bool
    var message: String?
}
