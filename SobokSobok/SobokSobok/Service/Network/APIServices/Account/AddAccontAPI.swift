//
//  AddAccontAPI.swift
//  SobokSobok
//
//  Created by 김선오 on 2022/01/19.
//

import Foundation
import Moya

public struct AddAccountAPI {
    
    static let shared = AddAccountAPI()
    var addAccountProvider = MoyaProvider<AddAccountService>()
    
    private init() { }
    
    func searchNickname(username: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        addAccountProvider.request(.searchNickname(username: username)) { (result) in
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, [SearchNicknameData].self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func saveNickname(memberId: Int, memberName: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        addAccountProvider.request(.saveNickname(memberId: memberId, memberName: memberName)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, [SaveNicknameData].self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type?) -> NetworkResult<Any> {
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
