//
//  SignUpModel.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/18.
//

import Foundation

// MARK: - SignUpResult
struct SignUpResult: Codable {
    let user: User?
    let accesstoken: String
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username, email, idFirebase, createdAt: String
    let updatedAt: String
}

// MARK: - CheckUsernameResult
struct CheckUsernameResult: Codable {}
