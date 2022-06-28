//
//  BaseModel.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/29.
//

import Foundation

struct BaseModel<T: Decodable>: Decodable {
    var status: Int
    var success: Bool
    var message: String?
    var data: T?
}
