//
//  AcceptPillInfoAPI.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/21.
//

import Foundation

import Moya

public struct AcceptPillInfoAPI {
    
    static let shared = AcceptPillInfoAPI()
    var acceptPillInfoProvider = MoyaProvider<AcceptPillInfoService>()
    
    private init() { }
    
    func putAcceptPillInfo(senderId: Int, receiverId: Int, createdAt: String, isOkay: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        acceptPillInfoProvider.request(.putAcceptPillInfo(senderId: senderId, receiverId: receiverId, createdAt: createdAt, isOkay: isOkay)) { result in
            print(result)
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data, [AcceptPillInfo].self)
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
