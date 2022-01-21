//
//  SignUpDataModel.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/18.
//

import UIKit

class SignUpUserData {
    static let shared = SignUpUserData()
    var email: String?
    var password: String?
    var name: String?
}
