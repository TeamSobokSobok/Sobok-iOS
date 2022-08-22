//
//  Notification+Extension.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/21.
//

import Foundation

extension Notification.Name {
    
    /*
     - 스티커 전체보기
     - 스티커 바텀 시트
     */
    static let showAllSticker = NSNotification.Name("showAllSticker")
    
    /*
     - 스티커 전송
     */
    static let sendSticker = NSNotification.Name("sendSticker")
}

extension Notification.Name {
    
    func post(object: Any? = nil, userInfo: [AnyHashable : Any]? = nil) {
        NotificationCenter.default.post(name: self, object: object, userInfo: userInfo)
    }

    @discardableResult
    func addObserver(object: Any? = nil, queue: OperationQueue? = nil, using: @escaping (Notification) -> Void) -> NSObjectProtocol {
        return NotificationCenter.default.addObserver(forName: self, object: object, queue: queue, using: using)
    }
    
    func removeObserver(observer: Any, object: Any? = nil) {
        return NotificationCenter.default.removeObserver(observer, name: self, object: object)
    }
}
