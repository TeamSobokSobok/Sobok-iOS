//
//  SignUpAPI.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/18.
//

import Foundation
import Moya

public class SignAPI {
    
    static let shared = SignAPI()
    var signProvider = MoyaProvider<SignService>()
    
    private init() {}
    
    func signIn(email: String, password: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        signProvider.request(.signIn(email: email, password: password)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, User.self)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func signUp(email: String, password: String, name: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        signProvider.request(.signUp(email: email, password: password, name: name)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, [SignUpResult].self)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func checkUsername(nickname: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        signProvider.request(.checkUsername(nickname: nickname)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, [CheckUsernameResult].self)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<T>.self, from: data)
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
