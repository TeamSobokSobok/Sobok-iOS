//
//  SignUpDataModel.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/18.
//

import UIKit

struct SignUpDataModel {
    var email: String?
    var password: String?
    var nickname: String?
}

extension SignUpDataModel {
    static var shared: SignUpDataModel = SignUpDataModel(email: "", password: "", nickname: "")
}
