//
//  CheckUsernameAPI.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/18.
//

import Foundation
import Moya

public class CheckUsernameAPI {
    
    static let shared = CheckUsernameAPI()
    var checkUsernameProvider = MoyaProvider<CheckUsernameService>()
    
    private init() {}
    
    func checkUsername(name: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        checkUsernameProvider.request(.checkUsername(name: <#T##String#>)) { (result) in
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
