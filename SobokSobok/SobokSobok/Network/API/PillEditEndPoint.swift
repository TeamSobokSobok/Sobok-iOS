//
//  PillEditEndPoint.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/25.
//

import Foundation

enum PillEditEndPoint {
    case putEditPill(pillId: Int, body: EditPill)
}

extension PillEditEndPoint: EndPoint {
    var method: HttpMethod {
        switch self {
        case .putEditPill:
            return .PUT
        }
    }
    
    var body: Data? {
        switch self {
        case .putEditPill(_, let body):
            return body.encode()
        }
    }
    func getURL(from environment: APIEnvironment) -> String {
        let baseURL = environment.baseURL
        switch self {
        case .putEditPill(let pillId, _):
            return "\(baseURL)/pill/\(pillId)"
        }
    }
}
