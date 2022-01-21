//
//  AddPillAPI.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/19.
//

import Foundation
import Moya

public class AddPillAPI {
    
    static let shared = AddPillAPI()
    var addPillProvider = MoyaProvider<AddPillService>()
    
    private init() {}
    
    func addMyPill(pillName: String, isStop: Bool, color: String, start: String, end: String, cycle: String, day: String, time: [String], specific: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        addPillProvider.request(.addMyPill(pillName: pillName, isStop: isStop, color: color, start: start, end: end, cycle: cycle, day: day, time: time, specific: specific)) { (result) in
            
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, PillListData.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func addFriendPill(memberId: Int, pillName: String, isStop: Bool, color: String, start: String, end: String, cycle: String, day: String, time: [String], specific: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        addPillProvider.request(.addFriendPill(memberId: memberId, pillName: pillName, isStop: isStop, color: color, start: start, end: end, cycle: cycle, day: day, time: time, specific: specific)) { (result) in
            
            switch result {
            case.success(let response):
                
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, PillListData.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ object: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try?
                decoder.decode(GenericResponse<T>.self, from: data)
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
