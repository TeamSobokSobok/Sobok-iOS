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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("1")
        
        TypoStyle.allCases.forEach {
            fontLabel[$0.rawValue]
                .setTypoStyle(
                    font: $0.font,
                    kernValue: $0.labelDescription.kern,
                    lineSpacing: $0.labelDescription.lineHeight
                )
        }
    }
}
