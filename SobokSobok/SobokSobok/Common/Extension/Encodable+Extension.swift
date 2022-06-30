//
//  Encodable+Extension.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/06/30.
//

import Foundation

extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
