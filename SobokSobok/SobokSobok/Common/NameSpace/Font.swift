//
//  Font.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/13.
//

import UIKit

enum FontType: String {
    case pretendardBlack = "Pretendard-Black"
    case pretendardBold = "Pretendard-Bold"
    case pretendardExtraBold = "Pretendard-ExtraBold"
    case pretendardExtraLight = "Pretendard-ExtraLight"
    case pretendardLight = "Pretendard-Light"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardReular = "Pretendard-Regular"
    case pretendardSemibold = "Pretendard-SemiBold"
    case pretendardThin = "Pretendard-Thin"
    
    var name: String {
        return self.rawValue
    }
}
