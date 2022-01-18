//
//  NoticeListCountAPI.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/01/18.
//

import Foundation

import Moya

public struct NoticeListCountAPI {
    
    static let shared = NoticeListCountAPI()
    var noticeListCountProvider = MoyaProvider<NoticeListCountService>()
    
    private init() { }
    
    func getNoticeListCount(completion: @escaping (NetworkResult<Any>) -> Void) {
        noticeListCountProvider.request(.getNoticeInfo) { result in
            
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
        guard let decodedData = try? decoder.decode(GenericResponse<NoticeInfo>.self, from: data)
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
        guard let decodedData = try? decoder.decode(GenericResponse<NoticeInfo>.self, from: data) else {return .pathErr}
        return .success(decodedData.data as Any)
    }
    
    private func isUsedPathErrData(data: Data)  -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<NoticeInfo>.self, from: data) else {return .pathErr}
        return .requestErr(decodedData)
    }
}
