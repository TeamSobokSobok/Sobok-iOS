//
//  SearchNicknameDataModel.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/19.
//

import UIKit

class SearchedUser {
    static let shared = SearchedUser()
    var searchedUsername: String?
    var searchedUserId: Int?
    var savedName: String?
}
