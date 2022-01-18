//
//  SignUpAPI.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/18.
//

import Foundation
import Moya

public class SignUpAPI {
    
    static let shared = SignUpAPI()
    var signUpProvider = MoyaProvider<SignUpService>()
    
    private init() {}
    
    func signUp(email: String, password: String, name: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        signUpProvider.request(.signUp(email: email, password: password, name: name)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data: data)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus(by statusCode: Int, data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try?
                decoder.decode(GenericResponse<SignUp>.self, from: data)
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data)
        case 400..<500:
            return .requestErr(decodedData.message)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
