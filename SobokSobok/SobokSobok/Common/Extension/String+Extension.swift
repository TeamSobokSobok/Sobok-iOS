//
//  String+Extension.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/07.
//

import Foundation

extension String {
    func addSeparator() -> String {
        let string = self.map{String($0)}
        let separator = string.joined(separator: ", ")
        return separator
    }
}
