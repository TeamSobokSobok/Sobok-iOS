//
//  NetworkRequest.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/28.
//

import Foundation

struct NetworkRequest {
    let url: String
    let httpMethod: HttpMethod
    let body: Data?                // optional
    let headers: [String: String]? // optional
    
    init(url: String,
         httpMethod: HttpMethod,
         requestBody: Data? = nil,
         headers: [String: String]? = nil
    ) {
        self.url = url
        self.httpMethod = httpMethod
        self.body = requestBody
        self.headers = headers
    }
    
    func createURLRequest(with url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = body
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        return urlRequest
    }
}
