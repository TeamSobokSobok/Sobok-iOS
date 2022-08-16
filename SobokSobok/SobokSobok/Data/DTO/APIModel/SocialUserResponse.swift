//
//  SocialUserResponse.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/16.
//

import Foundation

struct SignUpResponse: Codable {
    let id: Int
    let username: String
    let email: String
    let socialId: String
    let accesstoken: String
    let isNew: Bool
}

struct SignInResponse: Codable {
    let accesstoken: String
    let isNew: Bool
}
