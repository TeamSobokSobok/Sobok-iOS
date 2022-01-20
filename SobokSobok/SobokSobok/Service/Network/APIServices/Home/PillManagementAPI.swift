//
//  PillManagementAPI.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/19.
//
import UIKit
import Moya

struct PillManagementAPI {
    static let shared = PillManagementAPI()
    var pillManagementProvider = MoyaProvider<PillManagementService>()
    
    private init() { }
    
    public func stopPillList(pillId: Int, day: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        pillManagementProvider.request(.stopPillList(pillId: pillId, day: day)) { (result) in
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, Pill.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    public func deletePillList(pillId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        pillManagementProvider.request(.deletePillList(pillId: pillId)) { (result) in
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, Pill.self)
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
