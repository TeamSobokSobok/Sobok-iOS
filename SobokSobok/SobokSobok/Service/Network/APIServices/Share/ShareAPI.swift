//
//  ShareAPI.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/19.
//

import UIKit
import Moya

struct ShareAPI {
    static let shared = ShareAPI()
    var shareProvider = MoyaProvider<ShareService>()
    
    private init() { }
    
    public func getGroupInfo(completion: @escaping (NetworkResult<Any>) -> Void) {
        shareProvider.request(.getGroupInfomation) { (result) in
            
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, [Member].self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    public func getFriendCalendar(memberId: Int, date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        shareProvider.request(.getFriendCalendar(memberId: memberId, date: date)) { (result) in
            
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, [Schedule].self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    public func getFriendPillList(memberId: Int, date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        shareProvider.request(.getFriendPillList(memberId: memberId, date: date)) { (result) in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, [PillList].self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    public func editFriendUsername(groupId: Int, memberName: String, completion: @escaping(NetworkResult<Any>) -> Void) {
        shareProvider.request(.editFriendUsername(groupId: groupId, memberName: memberName)) { (result) in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, [EditFriendUsername].self)
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
