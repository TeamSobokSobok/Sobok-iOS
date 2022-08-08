//
//  String+Extension.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/07.
//

import Foundation

extension String {
    func addSeparator() -> String {
        let string = self.map { String($0) }
        let separator = string.joined(separator: ", ")
        return separator
    }
    
    func changeKrToEn() -> String {
        return self.replacingOccurrences(of: "달에 한 번", with: "month")
                    .replacingOccurrences(of: "주에 한 번", with: "week")
                    .replacingOccurrences(of: "일에 한 번", with: "day")
    }
}
