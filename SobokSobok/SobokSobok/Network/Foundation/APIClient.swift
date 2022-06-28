//
//  APIClient.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/28.
//

import Foundation

protocol Requestable: AnyObject {
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T?
}

final class APIClient {
    
}
