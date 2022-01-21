//
//  StickerAPI.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/20.
//

import UIKit
import Moya

struct StickerAPI {
    static let shared = StickerAPI()
    var shareProvider = MoyaProvider<StickerService>()
    
    private init() { }
    
    public func checkSticker(scheduleId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        shareProvider.request(.checkSticker(scheduleId: scheduleId)) { (result) in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, [Stickers].self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    public func postSticker(scheduleId: Int, stickerId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        shareProvider.request(.postSticker(scheduleId: scheduleId, stickerId: stickerId)) { (result) in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, Sticker.self)
                completion(networkResult)
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    public func editSticker(likeScheduleId: Int, stickerId: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        shareProvider.request(.editSticker(likeScheduleId: likeScheduleId, stickerId: stickerId)) { (result) in
            switch result {
            case.success(let response):
                let statusCode = response.statusCode
                let data = response.data
                
                let networkResult = self.judgeStatus(by: statusCode, data, Sticker.self)
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
