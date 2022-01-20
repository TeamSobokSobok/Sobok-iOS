//
//  SignInAPI.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/18.
//

import Foundation
import Moya

public class SignInAPI {
    
    static let shared = SignInAPI()
    var signInProvider = MoyaProvider<SignInService>()
    
    private init() {}
    
    func signIn(email: String, password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        signInProvider.request(.signIn(email: email, password: password)) { (result) in
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
                decoder.decode(GenericResponse<User>.self, from: data)
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return .success(decodedData.data as Any)
        case 400..<500:
            return .requestErr(decodedData.message as Any)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
