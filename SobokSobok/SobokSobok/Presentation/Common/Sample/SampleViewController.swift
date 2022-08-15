//
//  SampleViewController.swift
//  SobokSobok
//
//  Created by taehy.k on 2022/01/07.
//

import UIKit

import EasyKit
import IQKeyboardManagerSwift
import Kingfisher
import Lottie
import Moya
import SnapKit
import Then

final class SampleViewController: BaseViewController {

    @IBOutlet var fontLabel: [UILabel]!
    let calendar = CalendarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(calendar)
        calendar.snp.makeConstraints {
            $0.width.height.equalTo(350)
            $0.center.equalToSuperview()
        }
        
        calendar.delegate = self
        print("시작일로부터 3개월 선택 상황", calendar.firstDate, calendar.lastDate)
    }
}

extension SampleViewController: CalendarViewDelegate {
    func didSelectFirstDate(_ calendar: CalendarView) {
        print("처음 날짜", calendar.firstDate)
    }
    
    func didSelectLastDate(_ calendar: CalendarView) {
        print("마지막 날짜", calendar.lastDate)
    }
}
