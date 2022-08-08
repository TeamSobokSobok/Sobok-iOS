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
    }
}
