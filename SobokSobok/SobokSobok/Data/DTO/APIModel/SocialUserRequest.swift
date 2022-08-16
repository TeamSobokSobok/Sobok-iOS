//
//  SocialUserRequest.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/16.
//

import Foundation

struct SocialUserRequest: Codable {
    let socialId: String
    let username: String
    let deviceToken: String
}
