//
//  PillMoreInfoAPI.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/18.
//

import Foundation

import Moya

public struct PillMoreInfoAPI {
    
    static let shared = PillMoreInfoAPI()
    var pillMoreInfoProvider = MoyaProvider<PillMoreInfoService>()
    
    private init() { }
    
    func getPillMoreInfo(senderId: Int, receiverId: Int, createdAt: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        pillMoreInfoProvider.request(.getPillMoreInfo(senderId: senderId, receiverId: receiverId, createdAt: createdAt)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(by: statusCode, data)
                completion(networkResult)
            case .failure(let err):
                print(err)
            }
        }
    }
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<PillMoreInfo>.self, from: data)
        else {
            return .pathErr
        }
        
        switch statusCode {
        case 200:
            return isValidData(data: data)
        case 400:
            return isUsedPathErrData(data: data)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    private func isValidData(data: Data) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<PillMoreInfo>.self, from: data) else {return .pathErr}
        return .success(decodedData)
    }
    
    private func isUsedPathErrData(data: Data)  -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<PillMoreInfo>.self, from: data) else {return .pathErr}
        return .requestErr(decodedData)
    }
}
