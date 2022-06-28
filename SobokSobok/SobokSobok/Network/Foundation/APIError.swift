//
//  APIError.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/28.
//

import Foundation

enum APIError: Error {
    case urlEncodingError
    case clientError(message: String?)  // 4XX
    case serverError                    // 5XX
}
