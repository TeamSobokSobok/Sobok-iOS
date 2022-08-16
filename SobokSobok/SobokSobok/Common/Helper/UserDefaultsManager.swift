//
//  UserDefaultsManager.swift
//  SobokSobok
//
//  Created by taekki on 2022/08/16.
//

import Foundation

@propertyWrapper
struct UserDefaultWrapper<T> {
    private let key: String
    private let defaultValue: T
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

enum UserDefaultKeys: String, CaseIterable {
    case fcmToken
}

struct UserDefaultsManager {
    @UserDefaultWrapper(key: UserDefaultKeys.fcmToken.rawValue, defaultValue: "")
    static var fcmToken: String

}

extension UserDefaultsManager {
    
    static func reset() {
        UserDefaultKeys.allCases.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
}
