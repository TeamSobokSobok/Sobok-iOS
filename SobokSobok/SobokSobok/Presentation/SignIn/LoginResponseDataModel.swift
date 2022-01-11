//
//  LoginResponseDataModel.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/11.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let status: Int
    let success: Bool
    let message: String
    let data: Datum?
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let nickname, email, uid, accesstoken: String
    let createdAt, updatedAt: String
}
