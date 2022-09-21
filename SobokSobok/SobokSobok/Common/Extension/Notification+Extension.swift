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
    
    /*
     - 멤버 정보 탭
     */
    static let tapMember = NSNotification.Name("tapMember")
    
    /*
     - 알림 목록 전체보기
     - 약 ・ 친구 수락, 거절
     - 푸시알림 클릭
     */
    static let requestPill = Notification.Name("requestPill")
    static let requestFriend = Notification.Name("requestFriend")
    static let userRespondsPush = Notification.Name("userRespondsPush")
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
