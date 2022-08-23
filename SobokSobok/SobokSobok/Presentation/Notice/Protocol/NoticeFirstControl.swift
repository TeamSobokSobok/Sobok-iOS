//
//  NoticeFirstControl.swift
//  SobokSobok
//
//  Created by 정은희 on 2022/07/26.
//

import Foundation

protocol NoticeFistControl: DelegationProtocol { }

protocol NoticeListPresentable {
    func setupView(section: SectionType, status: StatusType)
    func setupConstraint()
    func divideSection()
}

enum SectionType: Int {
    case pill
    case calender
}
enum StatusType: Int {
    case waite
    case done
}
