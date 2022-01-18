//
//  PillCountAPI.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/01/17.
//

import Foundation
import Moya

public struct PillCountAPI {
    
    static let shared = PillCountAPI()
    var pillCountProvider = MoyaProvider<PillCountService>()
    
    private init() { }
    
    func getMyPillCount(completion: @escaping (NetworkResult<Any>) -> Void) {
        pillCountProvider.request(.getMyPillCount) { (result) in
            
            switch result {
            case.success(let response):
                
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
        guard let decodedData = try? decoder.decode(GenericResponse<PillCount>.self, from: data)
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
