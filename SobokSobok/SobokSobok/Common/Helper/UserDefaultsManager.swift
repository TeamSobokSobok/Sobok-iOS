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
    case socialID
    case accessToken
    case userName
}

struct UserDefaultsManager {
    @UserDefaultWrapper(key: UserDefaultKeys.fcmToken.rawValue, defaultValue: "")
    static var fcmToken: String
    
    @UserDefaultWrapper(key: UserDefaultKeys.socialID.rawValue, defaultValue: "")
    static var socialID: String
    
    @UserDefaultWrapper(key: UserDefaultKeys.accessToken.rawValue, defaultValue: "")
    static var accessToken: String
    
    @UserDefaultWrapper(key: UserDefaultKeys.userName.rawValue, defaultValue: "")
    static var userName: String
}

extension UserDefaultsManager {
    
    static func reset() {
        UserDefaultKeys.allCases.forEach { key in
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
    }
}

extension UserDefaults {
    enum Key: String {
        case member
    }
    
    var member: [Member] {
        get {
            guard let data = UserDefaults.standard.data(forKey: Key.member.rawValue) else { return [] }
            
            return (try? PropertyListDecoder().decode([Member].self, from: data)) ?? []
        }
        set {
            UserDefaults.standard.setValue(
                try? PropertyListEncoder().encode(newValue),
                forKey: Key.member.rawValue
            )
        }
    }
}
