//
//  ScheduleAPI.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/18.
//

import UIKit
import Moya

struct ScheduleAPI {
    static let shared = ScheduleAPI()
    var scheduleProvider = MoyaProvider<ScheduleService>()
    
    private init() { }
    
    public func getCalendar(date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        scheduleProvider.request(.getCalendar(date: date)) { (result) in
            
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
    
    public func getPillList(date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        scheduleProvider.request(.getPillList(date: date)) { (result) in
            
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
    
    public func checkPill(scheduleId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        scheduleProvider.request(.checkPillDetail(scheduleId: scheduleId)) { (result) in
            
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, PillDetail.self)
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
