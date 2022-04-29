//
//  PillPeriodViewController.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/03/06.
//

import UIKit

final class PillPeriodViewController: BaseViewController {

    let pillPeriodView = PillPeriodView()
    var delegate: PopUpDelegate?
    override func loadView() {
        self.view = pillPeriodView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

   
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true) {
            self.delegate?.popupDismissed()
        }
    }
    
    override func style() {
        super.style()
        view.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
    }
}
