//
//  TabBarItem.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/10.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case home
    case share
    case notice
    case medicine
}

extension TabBarItem {
    var title: String {
        switch self {
        case .home:         return "홈"
        case .share:        return "공유"
        case .notice:       return "알림"
        case .medicine:     return "약추가"
        }
    }
}

extension TabBarItem {
    var inactiveIcon: UIImage? {
        switch self {
        case .home:         return Image.icHomeInactive
        case .share:        return Image.icShareInactive
        case .notice:       return Image.icAlarmInactive
        case .medicine:     return Image.icPlusInactive
        }
    }
    
    var activeIcon: UIImage? {
        switch self {
        case .home:         return Image.icHomeActive
        case .share:        return Image.icShareActive
        case .notice:       return Image.icAlarmActive
        case .medicine:     return Image.icPlusActive
        }
    }
}

extension TabBarItem {
    public func asTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: inactiveIcon,
            selectedImage: activeIcon
        )
    }
}
