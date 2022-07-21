//
//  EndPoint.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/30.
//

import Foundation

protocol EndPoint {
    var method: HttpMethod { get }
    var body: Data? { get }
    
    func getURL(from environment: APIEnvironment) -> String
    func createRequest(environment: APIEnvironment) -> NetworkRequest
}

extension EndPoint {
    func createRequest(environment: APIEnvironment) -> NetworkRequest {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        headers["accesstoken"] = environment.token
        return NetworkRequest(url: getURL(from: environment),
                              httpMethod: method,
                              requestBody: body,
                              headers: headers)
    }
}
