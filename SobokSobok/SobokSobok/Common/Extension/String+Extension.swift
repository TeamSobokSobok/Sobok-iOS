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
    
    func changeEnToKr() -> String {
        return self.replacingOccurrences(of: "month", with: "달에 한 번")
            .replacingOccurrences(of: "week", with: "주에 한 번")
            .replacingOccurrences(of: "day", with: "일에 한 번")
    }
    
    func colorTypeToImageName() -> String {
        return self.replacingOccurrences(of: "1", with: "Ellipse38")
            .replacingOccurrences(of: "2", with: "Ellipse64")
            .replacingOccurrences(of: "3", with: "Ellipse65")
            .replacingOccurrences(of: "4", with: "Ellipse94")
            .replacingOccurrences(of: "5", with: "Ellipse95")
    }
}
