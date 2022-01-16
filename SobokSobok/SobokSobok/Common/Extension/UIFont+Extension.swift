//
//  UIFont+Extension.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/13.
//

import UIKit

extension UIFont {
    static func font(_ type: FontType, ofSize size: CGFloat) -> UIFont {
        return UIFont(name: type.rawValue, size: size)!
    }
}
