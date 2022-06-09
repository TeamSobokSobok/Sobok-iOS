//
//  Helper.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/06/07.
//

import Foundation

class Helper<T> {
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
