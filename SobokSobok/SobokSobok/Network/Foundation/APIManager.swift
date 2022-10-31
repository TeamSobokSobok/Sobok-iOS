//
//  APIManager.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/28.
//

import Foundation

protocol Requestable: AnyObject {
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T?
}

final class APIManager: Requestable {
    func request<T: Decodable>(_ request: NetworkRequest) async throws -> T? {
        guard let encodedURL = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: encodedURL) else {
            throw APIError.urlEncodingError
        }
        
        let (data, response) = try await URLSession.shared.data(for: request.createURLRequest(with: url))
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<500) ~= httpResponse.statusCode else {
            throw APIError.serverError
        }

        let decodedData = try JSONDecoder().decode(BaseModel<T>.self, from: data)
        print(decodedData)
        if decodedData.success {
            return decodedData.data
        } else {
            throw APIError.clientError(message: decodedData.message)
        }
    }
}
