//
//  PillColorType.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/05.
//

import UIKit

enum PillColorType {}

extension PillColorType {
    
    static let pillColors: [String: UIColor] = [
        "1": Color.pillColorRed,
        "2": Color.pillColorOrange,
        "3": Color.pillColorPurple,
        "4": Color.pillColorBlue,
        "5": Color.pillColorPink
    ]
}
