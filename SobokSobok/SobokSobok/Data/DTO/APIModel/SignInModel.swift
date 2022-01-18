//
//  SignInModel.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/18.
//

import Foundation

// MARK: - SignIn
struct SignIn: Codable {
    let data: SignInResult?
}

// MARK: - SignInResult
struct SignInResult: Codable {
    let id: Int
    let username, email, idFirebase, accessToken: String
    let createdAt, updatedAt: String
}
