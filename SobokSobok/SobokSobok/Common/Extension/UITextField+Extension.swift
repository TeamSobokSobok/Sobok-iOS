//
//  UITextField+Extension.swift
//  SobokSobok
//
//  Created by 김승찬 on 2022/08/08.
//

import UIKit

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
